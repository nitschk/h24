using System;
using System.Linq;
using System.Windows.Forms;

namespace h24
{
    public partial class frmSetup : Form
    {
        klc01 db;
        public frmSetup()
        {
            InitializeComponent();
        }

        private void frmSetup_Load(object sender, EventArgs e)
        {
            db = new klc01();
            dgSettings.DataSource = db.settings.ToList();
        }

        private void dgSettings_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            db.SaveChanges();
        }

        private void BtUpdateROC_Click(object sender, EventArgs e)
        {
            bool service_roc_start = false;
            if(this.CbROC.Checked)
            {
                service_roc_start = true;
            }
            _ = NewCard.StartEndRocService(service_roc_start);
        }

        private void CbROC_CheckedChanged(object sender, EventArgs e)
        {
            if(this.CbROC.Checked)
            {
                this.BtUpdateROC.Text = "Start";
            }
            else
            {
                this.BtUpdateROC.Text = "Stop";
            }
        }

        private void btSaveSettings_Click(object sender, EventArgs e)
        {
            //SettingsManager sm = new SettingsManager();
            SettingsManager.LoadSettings();
        }
    }
}
