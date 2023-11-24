using Microsoft.Reporting.WinForms;
using Microsoft.Win32;
using Newtonsoft.Json;
using SPORTident;
using SPORTident.Common;
using SPORTident.Communication;
using SPORTident.Communication.UsbDevice;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.Data.SqlTypes;
using System.Drawing;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using System.Collections.Specialized;
using Timer = System.Threading.Timer;

namespace h24
{
  public partial class FrmMain : Form
  {
    klc01 db;
    private readonly Reader _reader;
    private const string SerialPortSettingsName = "SerialPort";

    private bool _connected;
    private Dictionary<int, DeviceInfo> _deviceInfoList;

        private Timer apiRequestTimer;

    public FrmMain()
    {
      InitializeComponent();

      _reader = new Reader
      {
        WriteBackupFile = true,
        BackupFileName = Path.Combine(Environment.CurrentDirectory, $@"backup\{DateTime.Now:yyyy-MM-dd}_stamps.bak"),
        WriteLogFile = false
      };

      _reader.InputDeviceChanged += _reader_InputDeviceChanged;
      _reader.InputDeviceStateChanged += _reader_InputDeviceStateChanged;
      _reader.LogEvent += _reader_LogEvent;
      _reader.ErrorOccured += _reader_ErrorOccured;
      _reader.SiCardReadCompleted += _reader_CardRead;
      _reader.DeviceConfigurationRead += _reader_DeviceConfigurationRead;

      _refreshDeviceList();

            // Initialize the timer but don't start it immediately
            apiRequestTimer = new Timer(CheckApiRequests, null, Timeout.Infinite, Timeout.Infinite);

            // Attach the event handler for the checkbox
            cbQueueProcess.CheckedChanged += cbQueueProcess_CheckedChanged;

            this.Resize += new EventHandler(FrmMain_Resize);
    }

        private void _refreshDeviceList()
        {
            cmbSerialPort.Items.Clear();

            _deviceInfoList = new Dictionary<int, DeviceInfo>();

            var devList = DeviceInfo.GetAvailableDeviceList(true, (int)DeviceType.Serial | (int)DeviceType.UsbHid);

            var n = 0;
            DeviceInfo addItem;

            foreach (var item in devList)
            {
                addItem = item;

                var deviceName = DeviceInfo.GetPrettyDeviceName(item);
                cmbSerialPort.Items.Add(deviceName);
                _deviceInfoList.Add(n++, addItem);
            }

            var value = GetSettings(SerialPortSettingsName);
            if (value != null)
            {
                cmbSerialPort.SelectedItem = value;
                //Pokud je neco vybrano, zkusim to connectnout
                if (cmbSerialPort.SelectedIndex >= 0)
                    _connectDisconnect();
            }
            else if (cmbSerialPort.Items.Count > 0) cmbSerialPort.SelectedIndex = 0;
        }

        private void SetSettings(string name, string value)
        {
            using (RegistryKey key = Registry.CurrentUser.CreateSubKey(@"SOFTWARE\H24", true))
            {
                key.SetValue(name, value);
            }
        }

        private string GetSettings(string name)
        {
            using (RegistryKey key = Registry.CurrentUser.CreateSubKey(@"SOFTWARE\H24", false))
            {
                return (string)key.GetValue(name, null);
            }
        }


        #region Reader event handlers

        /// <summary>Handles the event that is thrown when the reader class read a card completely</summary>
        private void _reader_CardRead(object sender, SportidentDataEventArgs readoutData)
    {
      try
      {
        if (readoutData == null || readoutData.Cards == null || readoutData.Cards.Count() < 1)
        {
          return;
        }

        //handle this event to further process a read out card
        //you will find the card data in the e.Card array that may contain several cards
        //SportidentCard card = readoutData.Cards[0];
        SportidentCard newCard = readoutData.Cards.FirstOrDefault();
        if (newCard == null)
        {
          return;
        }

        Task.Run(async () => await NewResultAvailable(newCard));
      }catch (Exception e)
      {
        MessageBox.Show($"Neodchycená vyjimka:\n{e.Message}\n{e.StackTrace}");
      }
    }

    private void RefreshLegs()
    {
      //dataGridView1.Table.... Bind data here (this method would be executed on UI thread)
      var query = (from r in db.si_readout
                   join l in db.legs on r.readout_id equals l.readout_id into gl
                   from x in gl.DefaultIfEmpty()
                   join c in db.competitors on x.comp_id equals c.comp_id into gc
                   from y in gc.DefaultIfEmpty()
                     //join cr in db.courses on x.course_id equals cr.course_id into gr
                     //from z in gr.DefaultIfEmpty()
                     //join t in db.teams on y.team_id equals t.team_id into gt
                     //from a in gt.DefaultIfEmpty()
                   join s in db.slips on r.readout_id equals s.readout_id into gs
                   from b in gs.DefaultIfEmpty()
                     //orderby r.readout_id descending
                   select new
                   {
                     readout_id = r.readout_id,
                     chip_id = r.chip_id,
                     card_readout_datetime = r.card_readout_datetime,
                     comp_id = x != null ? x.comp_id : 0,
                     start_time = x != null ? x.start_time : "",
                     finish_time = x != null ? x.finish_time : "",
                     leg_time = x != null ? x.leg_time : "",
                     leg_status = x != null ? x.leg_status : "",
                     dsk_penalty = x != null ? x.dsk_penalty : null,
                     comp_name = y != null ? y.comp_name : "",
                     rank_order = y != null ? y.rank_order : 0,
                     bib = y != null ? y.bib : "",
                     course = b != null ? b.course_name : "",
                     team = b != null ? b.team_name : "",
                     leg_id = x != null ? x.leg_id : 0,
                     valid_flag = x != null ? x.valid_flag : true,
                     race_valid = b != null ? b.valid_flag : true,
                   } /*into e
                         group e by new
                         {
                            e.readout_id,
                            e.chip_id,
                            e.card_readout_datetime,
                            e.comp_id,
                            e.start_time,
                            e.finish_time,
                            e.leg_time,
                            e.leg_status,
                            e.dsk_penalty,
                            e.comp_name,
                            e.rank_order,
                            e.bib,
                            e.course,
                            e.team,
                            e.leg_id,
                            e.valid_flag,
                            e.race_valid
                          }*/
                   ).Distinct().OrderByDescending(x => x.readout_id).ToList();

      dgLegs.DataSource = query;
      dgLegs.Update();
      dgLegs.Refresh();
      dgLegs.Columns["card_readout_datetime"].DefaultCellStyle.Format = "dd. MM. yyyy HH:mm:ss";
    }

    /// <summary>Handles the event that is thrown when the reader class read an online stamp completely</summary>
    private void _reader_OnlineStampRead(object sender, SportidentDataEventArgs e)
    {
      //handle this event to further process a read card punch or online record
      //you will find the card data in the e.PunchData array hat may contain several records
    }
    /// <summary>Handles the event that is thrown when the reader class logs a message (info, warning, error...)</summary>
    private static void _reader_LogEvent(object sender, FileLoggerEventArgs e)
    {

    }

    /// <summary>Handles the event that is thrown when the reader class indicates a state change for the input device</summary>
    private void _reader_InputDeviceStateChanged(object sender, ReaderDeviceStateChangedEventArgs e)
    {
      if (InvokeRequired)
      {
        Invoke(new ReaderDeviceStateChangedEventHandler(_reader_InputDeviceStateChanged), sender, e);
        return;
      }

      switch (e.CurrentState)
      {
        case DeviceState.D0Online:
          txtInfo.Text += "INPUT device connected" + Environment.NewLine;

          break;
        case DeviceState.D5Busy:
          txtInfo.Text += "INPUT device working" + Environment.NewLine;

          break;
        default:
          txtInfo.Text += "INPUT device disconnected" + Environment.NewLine;

          break;
      }
    }
    /// <summary>Handles the event that is thrown when the reader class indicates a state change for the output device</summary>
    private void _reader_OutputDeviceStateChanged(object sender, ReaderDeviceStateChangedEventArgs e)
    {
      if (InvokeRequired)
      {
        Invoke(new ReaderDeviceStateChangedEventHandler(_reader_OutputDeviceStateChanged), sender, e);
        return;
      }

      switch (e.CurrentState)
      {
        case DeviceState.D0Online:
          txtInfo.Text += "OUTPUT device connected" + Environment.NewLine;

          break;
        case DeviceState.D5Busy:
          txtInfo.Text += "OUTPUT device working" + Environment.NewLine;

          break;
        default:
          txtInfo.Text += "OUTPUT device disconnected" + Environment.NewLine;

          break;
      }
    }
    /// <summary>Handles the event that is thrown when the reader class indicates that the input device has changed</summary>
    private void _reader_InputDeviceChanged(object sender, ReaderDeviceChangedEventArgs e)
    {
      if (InvokeRequired)
      {
        Invoke(new ReaderDeviceChangedEventHandler(_reader_InputDeviceChanged), sender, e);
        return;
      }

      var inputSource = string.Empty;

      switch (e.CurrentDevice.ReaderDeviceType)
      {
        case ReaderDeviceType.SiDevice:
          inputSource = DeviceInfo.GetPrettyDeviceName(e.CurrentDevice);
          break;
        case ReaderDeviceType.SiLiveSoapService:
          inputSource = "SPORTident Live SOAP Service";
          break;
        default:
          inputSource = e.CurrentDevice.ReaderDeviceType.ToString();
          break;
      }

      txtInfo.Text += "INPUT via " + inputSource + Environment.NewLine;
    }
    /// <summary>Handles the event that is thrown when the reader class indicates that the output device has changed</summary>
    private void _reader_OutputDeviceChanged(object sender, ReaderDeviceChangedEventArgs e)
    {
      if (InvokeRequired)
      {
        Invoke(new ReaderDeviceChangedEventHandler(_reader_OutputDeviceChanged), sender, e);
        return;
      }

      var outputSourceLong = string.Empty;

      switch (e.CurrentDevice.ReaderDeviceType)
      {
        case ReaderDeviceType.Textfile:
          outputSourceLong = e.CurrentDevice.FilePath;
          break;
        case ReaderDeviceType.Database:
          outputSourceLong = string.Format("{1}@{0}", e.CurrentDevice.Hostname, e.CurrentDevice.DatabaseType);
          break;
        case ReaderDeviceType.None:
          outputSourceLong = "None";
          break;
        case ReaderDeviceType.Plugin:
          outputSourceLong = "Plugin: " + e.CurrentDevice.DeviceName;
          break;
      }

      txtInfo.Text += "OUTPUT via " + outputSourceLong + Environment.NewLine;
    }

    private void _reader_ErrorOccured(object sender, FileLoggerEventArgs e)
    {
      if (InvokeRequired)
      {
        Invoke(new FileLoggerEventHandler(_reader_ErrorOccured), sender, e);
        return;
      }

      MessageBox.Show($"{e.Message}\n\n{e.ThrownException?.Message}", "ReaderDemoProject", MessageBoxButtons.OK, MessageBoxIcon.Error);

      if (e.ThrownException?.Message != "Disconnected" || !_connected) return;

      _closeDevices();
      _refreshDeviceList();
    }
    /// <summary>Handles the event that is raised when a card has been pending too long to complete via radio readout and has been cancelled</summary>

    /// <summary>Handles the event that is thrown when the reader class indicates that the stations config has been read successfully</summary>
    private void _reader_DeviceConfigurationRead(object sender, StationConfigurationEventArgs e)
    {
      if (InvokeRequired)
      {
        Invoke(new DeviceConfigurationReadEventHandler(_reader_DeviceConfigurationRead), sender, e);
        return;
      }

      if (InvokeRequired)
      {
        Invoke(new DeviceConfigurationReadEventHandler(_reader_DeviceConfigurationRead), sender, e);
        return;
      }

      txtInfo.Text = "Unknown device";

      var msg = "no description available";
      var failed = false;
      switch (e.Result)
      {
        case StationConfigurationResult.OperatingModeNotSupported:
          msg = "The selected operating mode is not supported on the current device.";
          failed = true;
          break;
        case StationConfigurationResult.DeviceDoesNotHaveBackup:
          msg = "The device does not have a backup memory storage.";
          failed = true;
          break;
        case StationConfigurationResult.ReadoutMasterBackupNotSupported:
          msg = "Reading the backup of SI-Master with firmware < FW595 is not supported.";
          failed = true;
          break;
      }

      if (failed)
      {
        MessageBox.Show(
            $"The device configuration could not be read successfully. Reason is probably: {e.Result} ({msg})", "ReaderDemo", MessageBoxButtons.OK, MessageBoxIcon.Error);

        return;
      }

      switch (e.Device.Product.ProductFamily)
      {
        case ProductFamily.SimSrr:
          //case ProductFamily.SiGsmDn:
          txtInfo.Text =
              $"S/N: {e.Device.SerialNumber}, FW: {e.Device.FirmwareVersion}, OpMode: {e.Device.Product.ProductType}, Protocol: {e.Device.SimSrrUseModD3Protocol}, Channel: {e.Device.SimSrrChannel}{Environment.NewLine}";

          //check device configuration
          if (e.Device.SimSrrUseModD3Protocol != 1)
          {
            MessageBox.Show(
                "The device is not configured to use AIR+ protocol. To use extended features it is recommended to enable AIR+ protocol for this device.",
                "ReaderDemo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
          }

          break;
        case ProductFamily.Bs8SiMaster:
        case ProductFamily.Bsx7:
        case ProductFamily.Bsx8:
        case ProductFamily.Bs11Large:
        case ProductFamily.Bs11Small:
          txtInfo.Text =
              $"Code no.: {e.Device.CodeNumber} (S/N: {e.Device.SerialNumber}, FW: {e.Device.FirmwareVersion}), OpMode: {e.Device.OperatingMode}, AutoSend: {e.Device.AutoSendMode}, Legacy prot: {e.Device.LegacyProtocolMode}{Environment.NewLine}";

          //check device configuration
          if (e.Device.OperatingMode != OperatingMode.Readout && !e.Device.AutoSendMode)
          {
            MessageBox.Show(
                "The device is not configured to read cards and has not set autosend flag. No data can be processed from this station.\n\nPlease reconfigure!",
                "ReaderDemo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);

          }
          else if (e.Device.LegacyProtocolMode)
          {
            MessageBox.Show(
                "The device is configured to use legacy protocol.\nThis application does not support legacy protocol.\n\nPlease reconfigure!",
                "ReaderDemo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
          }

          break;
      }
    }

    #endregion
    /// <summary>
    /// Close input and output devices for Reader
    /// </summary>
    private void _closeDevices()
    {
      //release input device
      if (_reader.InputDeviceIsOpen) _reader.CloseInputDevice();

      //release output device
      if (_reader.OutputDeviceIsOpen) _reader.CloseOutputDevice();

      _connected = false;
    }

    /// <summary>
    /// Sets the input device for the current Reader instance
    /// </summary>
    private bool _setInputDevice()
    {
      ReaderDeviceInfo device = null;

      if (!_deviceInfoList.ContainsKey(cmbSerialPort.SelectedIndex) ||
          !ReaderDeviceInfo.IsDeviceValid(_deviceInfoList[cmbSerialPort.SelectedIndex].DeviceName))
      {
        MessageBox.Show("Could not determine device. Please refresh the device list and retry.",
            "h24", MessageBoxButtons.OK, MessageBoxIcon.Error);

        return false;
      }

      device = new ReaderDeviceInfo(_deviceInfoList[cmbSerialPort.SelectedIndex], ReaderDeviceType.SiDevice);

      try
      {
        _reader.InputDevice = device;
      }
      catch (Exception ex)
      {
        MessageBox.Show($"An exception occured preparing the device {device}: \n\n{ex.Message}.", "h24", MessageBoxButtons.OK, MessageBoxIcon.Error);
        return false;
      }

      return true;
    }
    private bool _setOutputDevice()
    {
      ReaderDeviceInfo newDevice = null;
      newDevice = new ReaderDeviceInfo(ReaderDeviceType.Textfile, string.Empty);
      newDevice.ListFormat = ListFormat.SiConfigReadout;

      //var filePath = ConfigurationManager.AppSettings["folderLocation"];
      newDevice.FilePath = "c:\\Temp\\event.csv";

      try
      {
        _reader.OutputDevice = newDevice;
      }
      catch (Exception ex)
      {
        MessageBox.Show($"An exception occured preparing the device {newDevice}: \n\n{ex.Message}.", "h24", MessageBoxButtons.OK, MessageBoxIcon.Error);
        return false;
      }

      return true;
    }

    private void _connectDisconnect()
    {
      //if connected -> disconnect or vice versa
      if (_connected)
      {
        _closeDevices();
        cmbSerialPort.Enabled = true;
      }
      else
      {
        //set input and output device
        if (!_setInputDevice()) return;
        if (!_setOutputDevice()) return;

        //open input and output device
        try
        {
          _reader.OpenInputDevice();
        }
        catch (Exception)
        {
          _closeDevices();

          MessageBox.Show("Could not open the input device, please check device configuration.",
              "h24", MessageBoxButtons.OK, MessageBoxIcon.Error);

          return;
        }

        _connected = true;
        cmbSerialPort.Enabled = false;
      }
    }

    private void Form1_Load(object sender, EventArgs e)
    {
      db = new klc01();
      dgTeams.DataSource = db.teams.ToList();

      dgTeams.Columns[1].Width = Properties.Settings.Default.dgTeams_Column1;
      dgTeams.Columns[2].Width = Properties.Settings.Default.dgTeams_Column2;
      dgTeams.Columns[3].Width = Properties.Settings.Default.dgTeams_Column3;
      dgTeams.Columns[4].Width = Properties.Settings.Default.dgTeams_Column4;

      RefreshLegs();

      foreach (string printname in PrinterSettings.InstalledPrinters)
      {
        cbPrinter.Items.Add(printname);
      }

      string default_printer;
      default_printer = NewCard.get_config_item("slip_printer");
      cbPrinter.SelectedItem = default_printer;

    }

    private void btnOpen_Click(object sender, EventArgs e)
    {
      _connectDisconnect();
    }

    private void btnRefresh_Click(object sender, EventArgs e)
    {
      _refreshDeviceList();
    }

    private void coursesToolStripMenuItem_Click(object sender, EventArgs e)
    {
      frmCourses f2 = new frmCourses();
      f2.ShowDialog();
    }

    private void clasesToolStripMenuItem_Click(object sender, EventArgs e)
    {
      frmClases f2 = new frmClases();
      f2.ShowDialog();
    }

    private void entriesToolStripMenuItem_Click(object sender, EventArgs e)
    {
      frmEntries f2 = new frmEntries(this);
      f2.ShowDialog();
    }

    private void dgTeams_SelectionChanged(object sender, EventArgs e)
    {
      RefreshDgCompetitors();
      /*            int curRow = dgTeams.CurrentRow.Index;
                  int team_id = Convert.ToInt32(dgTeams.Rows[curRow].Cells["team_id"].Value);

                  db.Configuration.ProxyCreationEnabled = false;
                  db.competitors.Load();
                  this.competitorsBindingSource1.DataSource = db.competitors.Local.ToBindingList().Where(c => c.team_id == team_id);*/
    }

    /// <summary>
    /// Called when new computed result is available.
    /// </summary>
    /// <param name="resultId">The new computed resultId</param>
    private async Task NewResultAvailable(SportidentCard card)
    {
      try
      {
        int readout_id = 0;
        //write punch log
        string filename = @"c:\temp\card_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".json";
        string filename_p = @"c:\temp\card_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + "_punches.json";
        File.WriteAllText(filename, JsonConvert.SerializeObject(card));
        File.WriteAllText(filename_p, JsonConvert.SerializeObject(card.ControlPunchList));
        DateTime cardReadout = card.ReadoutDateTime;
        string SiId = card.Siid;

        List<si_stamps> Stamps = new List<si_stamps>();
        LoadStamps(card, Stamps);

        using (var db = new klc01())
        {
          //save readout and stamps

          var newReadout = new si_readout
          {
            chip_id = card.Siid,
            card_readout_datetime = card.ReadoutDateTime,
            clear_datetime = card.ClearPunch.PunchDateTime < DateTime.Parse("01/01/1900") ? DateTime.Parse("01/01/1900") : card.ClearPunch.PunchDateTime,
            check_datetime = card.CheckPunch.PunchDateTime < DateTime.Parse("01/01/1900") ? DateTime.Parse("01/01/1900") : card.CheckPunch.PunchDateTime,
            start_datetime = card.StartPunch.PunchDateTime < DateTime.Parse("01/01/1900") ? DateTime.Parse("01/01/1900") : card.StartPunch.PunchDateTime,
            finish_datetime = card.FinishPunch.IsMissingOrEmpty == true ? card.ReadoutDateTime : card.FinishPunch.PunchDateTime,
            finish_missing = card.FinishPunch.IsMissingOrEmpty == true ? true : false,
            as_of_date = DateTime.Now,
            si_stamps = Stamps
          };

          try
          {
            db.si_readout.Add(newReadout);
            db.SaveChanges();
            readout_id = newReadout.readout_id;

            NewCard NewCard = new NewCard();
            NewCard.HandleNewCard(readout_id);
                        InvokeMethod(() => SetLastBib(readout_id));

            //print slip
            if (this.chbPrint.Checked)
            {
              this.PrintSlip(readout_id);
            }

            if (this.cbPost_Slips.Checked)
            {
              var result = await NewCard.PostSlip(readout_id);
                            this.InvokeMethod(() => { 
              this.txtInfo.AppendText(Environment.NewLine);
              this.txtInfo.AppendText(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + result.ToString());
                            });
                        }

            InvokeMethod(RefreshLegs);

          }
          catch (DbEntityValidationException ex)
          {
            string err = "";
            foreach (var eve in ex.EntityValidationErrors)
            {
              err += "Entity of type " + eve.Entry.Entity.GetType().Name + " in state " + eve.Entry.State + " has the following validation errors:";
              foreach (var ve in eve.ValidationErrors)
              {
                err += "- Property: " + ve.PropertyName + ", Error: " + ve.ErrorMessage + "";
              }
            }
            MessageBox.Show(err);
            throw;
          }
        };
      }catch(Exception e)
      {
        MessageBox.Show($"Neodchycená vyjimka:\n{e.Message}\n{e.StackTrace}");
      }
    }

    private static void LoadStamps(SportidentCard card, List<si_stamps> Stamps)
    {
      int i = 0;
      foreach (CardPunchData punchData in card.ControlPunchList)
      {
        si_stamps sStamp = new si_stamps();

        //Nejsou data
        if (punchData == null || punchData.IsMissingOrEmpty)
        {
          continue;
        }
        //Spatny OperatingMode?
        if (punchData.OperatingMode != OperatingMode.Control &&
                  punchData.OperatingMode != OperatingMode.DControl &&
                  punchData.OperatingMode != OperatingMode.BcControl &&
                  punchData.OperatingMode != OperatingMode.BcDControl)
        {
          continue;
        }
        i++;
        sStamp.chip_id = Int32.Parse(card.Siid);
        sStamp.control_code = punchData.CodeNumber.ToString();
        sStamp.control_mode = 2;
        sStamp.punch_datetime = punchData.PunchDateTime;
        sStamp.punch_wday = punchData.DayOfWeek.ToString();
        sStamp.punch_index = i;
        sStamp.as_of_date = DateTime.Now;

        Stamps.Add(sStamp);
      }
    }

    private void InvokeMethod(Action method)
    {
      if (InvokeRequired)
      {
        // after we've done all the processing, 
        Invoke(new MethodInvoker(method));
      }
      else
      {
        method();
      }
    }

    private void SetLastBib(int readout_id)
    {
      // InvokeRequired required compares the thread ID of the
      // calling thread to the thread ID of the creating thread.
      // If these threads are different, it returns true.
      var competitor = db.slips.Where(b => b.readout_id == readout_id).FirstOrDefault();

            if(competitor == null)
            {
                this.LbLastBib.Text = "Neznámý";
                this.LbStatus.Text = "??";
                this.LbPenal.Text = "??";
                return;
            }

      //string bib = competitor.bib;
      //string leg_status = competitor.leg_status;
      //string dsk_penalty = competitor.dsk_penalty.ToString();

      //this.LbLastBib.Text = bib;

      //display competitor details
      this.LbLastBib.Text = competitor.bib;
      this.LbStatus.Text = competitor.leg_status;
      this.LbPenal.Text = competitor.dsk_penalty.ToString();

      TimeSpan zeroSpan = new TimeSpan(0, 0, 0);
      if (competitor.leg_status != "OK" || TimeSpan.Compare((TimeSpan)competitor.dsk_penalty, zeroSpan) != 0)
      {
        this.LbLastBib.ForeColor = System.Drawing.Color.Red;
      }
      else
      {
        this.LbLastBib.ForeColor = System.Drawing.Color.Black;
      }

      if (competitor.leg_status != "OK")
      {
        this.LbStatus.ForeColor = System.Drawing.Color.Red;
      }
      else
      {
        this.LbStatus.ForeColor = System.Drawing.Color.Black;
      }

      if (TimeSpan.Compare((TimeSpan)competitor.dsk_penalty, zeroSpan) != 0)
      {
        this.LbPenal.ForeColor = System.Drawing.Color.Red;
      }
      else
      {
        this.LbPenal.ForeColor = System.Drawing.Color.Black;
      }



    }

    private void SlipCurrentRow_Click(object sender, EventArgs e)
    {
      int curRow = dgLegs.CurrentRow.Index;
      if (curRow > -1)
      {
        int readout_id = Convert.ToInt32(dgLegs.Rows[curRow].Cells["readout_id"].Value);

        frmSlip f2 = new frmSlip(readout_id);
        f2.ShowDialog();
      }

    }

    private void cbPrinter_SelectedValueChanged(object sender, EventArgs e)
    {
      using (var db = new klc01())
      {
        var result = NewCard.get_config_item("slip_printer");
        if (result != null)
        {
          result = cbPrinter.SelectedItem.ToString();
          db.SaveChanges();
        }
      }
    }

    private void chbPrint_CheckedChanged(object sender, EventArgs e)
    {
      if (cbPrinter.Enabled)
        cbPrinter.Enabled = false;
      else
        cbPrinter.Enabled = true;
    }

    private void PrintSlip(int readout_id)
    {
      string printerName = NewCard.get_config_item("slip_printer");
      if (cbPrinter.InvokeRequired)
      {
        //printerName = this.cbPrinter.Text; //"Microsoft Print to PDF";
        cbPrinter.Invoke(new MethodInvoker(delegate { printerName = this.cbPrinter.Text; }));
      }
      List<slips> slip = null;
      using (var db = new klc01())
      {
        slip = db.slips.Where(a => a.readout_id == readout_id).ToList();

        LocalReport report = new LocalReport();
        report.ReportPath = @"rptSlip1.rdlc";
        report.DataSources.Add(new ReportDataSource("dsSlip", slip));
        report.PrintToPrinter(printerName);
      }
    }

    private void btnReloadReadout_Click(object sender, EventArgs e)
    {

      long r;
      int curRow = dgLegs.CurrentRow.Index;
      if (curRow > -1)
      {
        int readout_id = Convert.ToInt32(dgLegs.Rows[curRow].Cells["readout_id"].Value);
        //int leg_id = Convert.ToInt32(dgLegs.Rows[curRow].Cells["leg_id"].Value);
        NewCard NewCard = new NewCard();
        //tady budu muset udelat novou funkci UpdateLeg(leg_id), aby se nepridaval novy leg, ale upravoval ten stavajici...
        r = NewCard.UpdateLeg(readout_id);
      }
      RefreshLegs();
      dgLegs.CurrentCell = dgLegs.Rows[curRow].Cells[1];
    }
    
    private void btnReloadReadoutSelection_Click(object sender, EventArgs e)
    {

      long r;
      foreach (DataGridViewRow curRow in dgLegs.SelectedRows)
            {


                //if (curRow > -1)
                //{
                    int readout_id = Convert.ToInt32(curRow.Cells["readout_id"].Value);
                    //int leg_id = Convert.ToInt32(dgLegs.Rows[curRow].Cells["leg_id"].Value);
                    NewCard NewCard = new NewCard();
                    //tady budu muset udelat novou funkci UpdateLeg(leg_id), aby se nepridaval novy leg, ale upravoval ten stavajici...
                    r = NewCard.UpdateLeg(readout_id);
                //}
            }
            RefreshLegs();
      //dgLegs.CurrentCell = dgLegs.Rows[curRow].Cells[1];
    }

    private void legsToolStripMenuItem_Click(object sender, EventArgs e)
    {
      frmLegs f2 = new frmLegs();
      f2.ShowDialog();
    }

    private void setupToolStripMenuItem_Click(object sender, EventArgs e)
    {
      frmSetup f = new frmSetup();
      f.ShowDialog();
    }

        private void resultsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmResults f = new FrmResults();
            f.ShowDialog();
        }


        private void btnPrintSlip_Click(object sender, EventArgs e)
    {
      int curRow = dgLegs.CurrentRow.Index;
      if (curRow > -1)
      {
        int readout_id = Convert.ToInt32(dgLegs.Rows[curRow].Cells["readout_id"].Value);
        string printerName = this.cbPrinter.Text; //"Microsoft Print to PDF";
        this.PrintSlip(readout_id);
      }
    }

    private void btn_delete_leg_Click(object sender, EventArgs e)
    {
      int curRow = dgLegs.CurrentRow.Index;
      if (curRow > -1)
      {
        int leg_id = Convert.ToInt32(dgLegs.Rows[curRow].Cells["leg_id"].Value);

        DialogResult dResult = MessageBox.Show("Really delete leg " + leg_id, "Delete Leg", MessageBoxButtons.YesNo);
        if (dResult == DialogResult.No)
        {
          this.Close();
        }
        else
        {
          using (var db = new klc01())
          {
            var result = db.legs.SingleOrDefault(b => b.leg_id == leg_id);
            if (result != null)
            {
              result.valid_flag = false;
              db.SaveChanges();
            }
          }
          RefreshLegs();
        }
      }

    }

    private void RefreshDgCompetitors()
    {
      int curRow;
      int team_id = 0;
      if (dgTeams.CurrentRow != null)
      {
        curRow = dgTeams.CurrentRow.Index;
        team_id = Convert.ToInt32(dgTeams.Rows[curRow].Cells["team_id"].Value);
      }

      db.Configuration.ProxyCreationEnabled = false;
      db.competitors.Load();
      this.competitorsBindingSource.DataSource = db.competitors.Local.ToBindingList().Where(c => c.team_id == team_id);

    }

    private void SearchComp(string tx)
    {
      using (var db = new klc01())
      {
        tx = txSearch.Text;
        string q = "SELECT DISTINCT t.* FROM teams AS t " +
"INNER JOIN competitors AS c ON t.team_id = c.team_id " +
 " WHERE t.team_name LIKE '%" + tx + "%'" +
" OR c.comp_name LIKE '%" + tx + "%'" +
" OR c.bib LIKE '%" + tx + "%'" +
" OR cast(c.comp_chip_id as varchar(10)) LIKE '%" + tx + "%'";
        var tms = db.teams.SqlQuery(q).ToList();

        dgTeams.DataSource = tms;
        dgTeams.Refresh();

      }

    }


    private void txSearch_TextChanged(object sender, EventArgs e)
    {
      if (txSearch.Text.Length > 0)
      {
        SearchComp(txSearch.Text);

        RefreshDgCompetitors();
      }
    }

    private void btSearch_Click(object sender, EventArgs e)
    {
      SearchComp(txSearch.Text);
      RefreshDgCompetitors();
    }


    private void button3_Click(object sender, EventArgs e)
    {
      int readout_id = 80;
      string printerName = this.cbPrinter.Text; //"Microsoft Print to PDF";
      this.PrintSlip(readout_id);
    }

    private void button1_Click(object sender, EventArgs e)
    {
      /*frmCourseNotFound frm = new frmCourseNotFound();
      frm.ShowDialog();*/
      //MessageBox.Show(frm.course.ToString());
      NewCard rs = new NewCard();
      //Act
      List<int> guessed_courseslong = rs.GuessCourse(65);
      foreach (int crs in guessed_courseslong)
        MessageBox.Show(crs.ToString());
    }

    private void dgLegs_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
    {
      //DataGridView dgLegs = sender as DataGridView;

      if (dgLegs.Columns[e.ColumnIndex].Name.Equals("valid_flag"))
      {
        if (e.Value != null && e.Value.ToString().Trim() == "False")
        {
          dgLegs.Rows[e.RowIndex].Cells["readout_id"].Style.ForeColor = Color.Gray;
        }
        else
        {
          dgLegs.Rows[e.RowIndex].Cells["readout_id"].Style.ForeColor = Color.Black;
        }
      }
    }

    private void dgLegs_CellPainting(object sender, DataGridViewCellPaintingEventArgs e)
    {
      if (e.RowIndex != -1)
      {
        /*               if (dgLegs.Rows[e.RowIndex].Cells["valid_flag"].Value.ToString() == "False")
                       {
                           e.Paint(e.CellBounds, e.PaintParts);
                           //e.Graphics.DrawLine(new Pen(Color.Black, 2), new Point(e.CellBounds.Left, e.CellBounds.Top), new Point(e.CellBounds.Right, e.CellBounds.Bottom));
                           e.Graphics.DrawLine(new Pen(Color.Black, 2), new Point(e.CellBounds.Left, (e.CellBounds.Bottom + e.CellBounds.Top) / 2 ),
                               new Point(e.CellBounds.Right, (e.CellBounds.Top + e.CellBounds.Bottom ) / 2));

                                               e.Handled = true;
                       }*/
      }
    }


    private void FrmMain_FormClosing(object sender, FormClosingEventArgs e)
    {
      Properties.Settings.Default.dgTeams_Column1 = dgTeams.Columns[1].Width;
      Properties.Settings.Default.dgTeams_Column2 = dgTeams.Columns[2].Width;
      Properties.Settings.Default.dgTeams_Column3 = dgTeams.Columns[3].Width;
      Properties.Settings.Default.dgTeams_Column4 = dgTeams.Columns[4].Width;
      // Set the width of every column of datagridview here
      Properties.Settings.Default.Save();// Save setting after setting all column width
    }

    private void btReloadAll_Click(object sender, EventArgs e)
    {
      long r;
      int curRow = dgLegs.CurrentRow.Index;
      if (curRow > -1)
      {
        int comp_id = Convert.ToInt32(dgLegs.Rows[curRow].Cells["comp_id"].Value);
        using (var db = new klc01())
        {
          List<int?> team_readout_ids;

          var query = (
              from c in db.competitors
              join ct in db.competitors on c.team_id equals ct.team_id
              join l in db.legs on ct.comp_id equals l.comp_id
              where c.comp_id == comp_id
              select new
              {
                readout_id = l.readout_id != null ? l.readout_id : 0,
                l.finish_dtime
              } into selection
              orderby selection.finish_dtime
              select selection.readout_id != null ? selection.readout_id : 0);
          team_readout_ids = query.ToList();

          foreach (int readout_id in team_readout_ids)
          {
            if (readout_id != 0)
            {
              NewCard NewCard = new NewCard();
              r = NewCard.UpdateLeg(readout_id);
            }
          }
        }
        RefreshLegs();
      }
    }

    private async void btnPostSlip_Click(object sender, EventArgs e)
    {
      int curRow = dgLegs.CurrentRow.Index;
      if (curRow > -1)
      {
        int readout_id = Convert.ToInt32(dgLegs.Rows[curRow].Cells["readout_id"].Value);

        NewCard NewCard = new NewCard();
        var result = await NewCard.PostSlip(readout_id);
        this.txtInfo.AppendText(Environment.NewLine);
        this.txtInfo.AppendText(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + result.ToString());
      }
    }

    private void btn_change_competitor_Click(object sender, EventArgs e)
    {
      int curRow = dgLegs.CurrentRow.Index;
      if (curRow > -1)
      {
        int readout_id = Convert.ToInt32(dgLegs.Rows[curRow].Cells["readout_id"].Value);
        int leg_id = Convert.ToInt32(dgLegs.Rows[curRow].Cells["leg_id"].Value);

        frmLegCompChange f2 = new frmLegCompChange(leg_id);
        f2.ShowDialog();

        NewCard NewCard = new NewCard();
        NewCard.UpdateLeg(readout_id);

      }
      RefreshLegs();
    }

    private void dgCompetitors_CellEndEdit(object sender, DataGridViewCellEventArgs e)
    {
        int curRow = dgTeams.CurrentRow.Index;
        int team_id = Convert.ToInt32(dgTeams.Rows[curRow].Cells["team_id"].Value);
            int curRowComp = dgCompetitors.CurrentRow.Index;
            int comp_id = Convert.ToInt32(dgCompetitors.Rows[curRowComp].Cells["competitor_id"].Value);
        db.SaveChanges();
        _ = NewCard.PostEntries(team_id);
        _ = NewCard.PostCompetitors(comp_id);
    }

    private void btnResults_Click(object sender, EventArgs e)
    {
      FrmResults f2 = new FrmResults();
      f2.ShowDialog();
    }

    private void btnWithdrawn_Click(object sender, EventArgs e)
    {
      int curRow = dgCompetitors.CurrentRow.Index;
      if (curRow > -1)
      {
        int comp_id = Convert.ToInt32(dgCompetitors.Rows[curRow].Cells["competitor_id"].Value);

        try
        {
          var result = db.competitors.SingleOrDefault(b => b.comp_id == comp_id);
          if (result != null)
          {

            DateTime now = DateTime.Now;
            result.comp_withdrawn = !result.comp_withdrawn;
            if (result.comp_withdrawn)
            {
              //withdrawn
              result.withdrawn_datetime = DateTime.Now;
              db.SaveChanges();

              //insert fake readout
              string chip_id = result.comp_chip_id.ToString();

              var newReadout = new si_readout
              {
                chip_id = chip_id,
                card_readout_datetime = now,
                as_of_date = now
              };
              db.si_readout.Add(newReadout);
              db.SaveChanges();

              int readout_id = newReadout.readout_id;

              //insert fake leg with 0 time and 30' penalty
              int dsk_penalty_min = 0;

              int course_id = db.courses.Where(b => b.course_name == "WDRN").Select(b => b.course_id).First();
              int team_id = (int)result.team_id;
              if (db.competitors.Where(b => b.team_id == team_id && b.comp_withdrawn == true).Count() > 1)
              {
                dsk_penalty_min = Int32.Parse(NewCard.get_config_item("dsk_penalty_min"));
              }

              TimeSpan dsk_penalty = TimeSpan.FromMinutes(dsk_penalty_min);

              var newLeg = new legs
              {
                comp_id = comp_id,
                course_id = course_id,
                readout_id = readout_id,
                start_dtime = now,
                finish_dtime = now,
                leg_status = "WDR",
                dsk_penalty = dsk_penalty,
                as_of_date = now,
                valid_flag = false
              };

              db.legs.Add(newLeg);
              db.SaveChanges();

              //update race end on team
              //NewCard NewCard = new NewCard();
              int y = NewCard.UpdateTeamRaceEnd(comp_id);
              //insert fake slip
              int cnt = int.Parse(db.sp_inset_wdr_slip(comp_id).ToString());
            }
            else
            {
              //cancel withdrawn
              result.withdrawn_datetime = null;
              db.SaveChanges();

              //remove fake slip
              int course_id = db.courses.Where(b => b.course_name == "WDRN").Select(b => b.course_id).First();
              slips oldSlip = db.slips.Where(b => b.comp_id == comp_id && b.course_id == course_id).First();
              int leg_id = oldSlip.leg_id;
              int readout_id = oldSlip.readout_id;
              db.slips.Remove(oldSlip);
              db.SaveChanges();

              //remove fake leg with 0 time and 30' penalty
              legs oldLeg = db.legs.Where(b => b.leg_id == leg_id).First();
              db.legs.Remove(oldLeg);
              db.SaveChanges();

              //remove fake readout
              si_readout oldReadout = db.si_readout.Where(b => b.readout_id == readout_id).First();
              db.si_readout.Remove(oldReadout);
              db.SaveChanges();

              //update race end on team
              NewCard NewCard = new NewCard();
              int y = NewCard.UpdateTeamRaceEnd(comp_id);
            }
          }
        }
        catch (Exception ex)
        {
          MessageBox.Show(ex.Message);
        }

      }
      RefreshDgCompetitors();
      RefreshLegs();
    }

    private void dgLegs_MouseDown(object sender, MouseEventArgs e)
    {
      if (e.Button == MouseButtons.Right)
      {
        ContextMenu m = new ContextMenu();
        m.MenuItems.Add(new MenuItem("Reload Stamps", new System.EventHandler(this.btnReloadReadout_Click)));
        m.MenuItems.Add(new MenuItem("Slip", new System.EventHandler(this.SlipCurrentRow_Click)));
        m.MenuItems.Add(new MenuItem("Print", new System.EventHandler(this.btnPrintSlip_Click)));
        m.MenuItems.Add(new MenuItem("Delete", new System.EventHandler(this.btn_delete_leg_Click)));
        m.MenuItems.Add(new MenuItem("Reload All", new System.EventHandler(this.btReloadAll_Click)));
        m.MenuItems.Add(new MenuItem("Change Competitor", new System.EventHandler(this.btn_change_competitor_Click)));
        m.MenuItems.Add(new MenuItem("Change Competitor", new System.EventHandler(this.btnRefreshLegs_Click)));

        /*
                        int currentMouseOverRow = dgLegs.HitTest(e.X, e.Y).RowIndex;

                        if (currentMouseOverRow >= 0)
                        {
                            m.MenuItems.Add(new MenuItem(string.Format("Refresh row {0}", currentMouseOverRow.ToString())));
                            dgLegs.ClearSelection();
                        //    dgLegs.Rows[hti.RowIndex].Selected = true;
                        }
        */
        m.Show(dgLegs, new Point(e.X, e.Y));
      }
    }

    private void btnRefreshLegs_Click(object sender, EventArgs e)
    {

      RefreshLegs();
    }

    private async void BtnPostAll_Click(object sender, EventArgs e)
    {

      var query = (
          from l in db.legs
          select new
          {
            readout_id = l.readout_id != null ? l.readout_id : 0,
            l.finish_dtime
          } into selection
          orderby selection.finish_dtime
          select new { selection.readout_id, selection.finish_dtime });
      var readout_ids = query.ToList();
      int i = 0;
            var timeout = DateTime.Now.AddHours(-11);

      foreach (var readout in readout_ids)
      {
                if ( (readout.readout_id ?? 0) == 0) continue;
        var result = await NewCard.PostSlip(readout.readout_id.Value);
        this.txtInfo.AppendText(Environment.NewLine);
        this.txtInfo.AppendText(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + result.ToString());
        i++;
        System.Threading.Thread.Sleep(500);
      }
      MessageBox.Show("Sent " + i + " legs");
    }

    private void FrmMain_Resize(object sender, EventArgs e)
    {
      //LbLastBib.Size = new Size(this.ClientSize.Width / 8, this.ClientSize.Height / 8);
      if(this.WindowState != FormWindowState.Minimized )
        LbLastBib.Font = new Font("Microsoft Sans Serif", this.ClientSize.Height / 8);
    }

    private void btnClearSearch_Click(object sender, EventArgs e)
    {
      txSearch.Text = "";
      SearchComp("");
    }

    private void cmbSerialPort_SelectedIndexChanged(object sender, EventArgs e)
    {
      if (!string.IsNullOrEmpty(cmbSerialPort.SelectedItem?.ToString()))
        SetSettings(SerialPortSettingsName, cmbSerialPort.SelectedItem.ToString());
    }

        private List<api_queue> GetPendingApiRequestsFromDatabase()
        {
            db = new klc01();
            string status_new = NewCard.get_config_item("q_status_to_sent");
            string status_done = NewCard.get_config_item("q_status_done");

            int queue_timeout = Int32.Parse(NewCard.get_config_item("api_queue_timeout"));
            DateTime latest = DateTime.Now.AddSeconds(-queue_timeout);

            var olderThanSeconds = db.api_queue
                .Where(a => a.q_status == status_new || (a.q_status != status_done && a.as_of_date < latest))
                .ToList();

            return olderThanSeconds; // Replace with actual implementation
        }

        private void cbQueueProcess_CheckedChanged(object sender, EventArgs e)
        {
            db = new klc01();
            int api_queue_timer = Int32.Parse(NewCard.get_config_item("api_queue_timer"));

            if (cbQueueProcess.Checked)
            {
                // Start the timer with the desired interval (e.g., every 5 seconds)
                apiRequestTimer.Change(TimeSpan.Zero, TimeSpan.FromSeconds(api_queue_timer));
            }
            else
            {
                // Stop the timer
                apiRequestTimer.Change(Timeout.Infinite, Timeout.Infinite);
            }
        }

        private void CheckApiRequests(object state)
        {
            // Check the database for pending requests
            List<api_queue> pendingRequests = GetPendingApiRequestsFromDatabase();

            foreach (api_queue apiRequest in pendingRequests)
            {
                // Update the status to In Progress
                UpdateApiRequestStatus(apiRequest.q_id, "In Progress");

                // Attempt to send the request to the API
                bool success = SendApiRequest(apiRequest);

                // Update the status based on the result
                UpdateApiRequestStatus(apiRequest.q_id, success ? "Sent" : "Failed");

/*                if (!success)
                {
                    // If the request fails, you can re-enqueue it or implement retry logic
                    // For simplicity, let's assume requests are removed on failure
                    MessageBox.Show("API request failed. Please check your internet connection.");
                }*/
            }
        }

        // Implement your method to send API requests here
        private bool SendApiRequest(api_queue request)
        {
            // Your API request implementation logic here
            // Return true if the request was successful, false if it failed
            return false; // Replace with actual logic
        }

        private void UpdateApiRequestStatus(int requestId, string status)
        {

            using (var db = new klc01())
            {
                var result = db.api_queue.SingleOrDefault(b => b.q_id == requestId);
                if (result != null)
                {
                    result.q_status = status;
                    db.SaveChanges();
                }
            }
        }

        /*
    private void Refresh_Readout(Object sender, EventArgs e)
    {
    if (this.dgLegs.GetCellCount(DataGridViewElementStates.Selected) > 0)
    {
       try
       {
           Clipboard.SetDataObject(this.dataGridView1.GetClipboardContent());
       }
       catch (System.Runtime.InteropServices.ExternalException)
       {
           MessageBox.Show("Clipboard could not be accessed. Please try again.");
       }
    }

    if (this.dataGridView1.SelectedRows.Count > 0)
    {
       dataGridView1.Rows.RemoveAt(this.dataGridView1.SelectedRows[0].Index);
    }

    }*/



    }

}
