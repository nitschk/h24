using CsvHelper;
using Microsoft.Reporting.WinForms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity;
using System.Drawing.Imaging;
using System.Drawing.Printing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TaskbarClock;

namespace h24
{
    public partial class FrmResults : Form
    {
        public FrmResults()
        {
            InitializeComponent();
        }

        private void FrmResults_Load(object sender, EventArgs e)
        {
            List<results> results = null;
            int cat_id = 2;
            using (var db = new klc01())
            {
                results = db.results.Where(a => a.cat_id == cat_id).ToList();

                this.reportViewer1.LocalReport.ReportPath = "rpt_results.rdlc";
                this.reportViewer1.LocalReport.DataSources.Clear();
                ReportDataSource rdc = new ReportDataSource("ds_result", results);
                this.reportViewer1.LocalReport.DataSources.Add(rdc);

                this.reportViewer1.RefreshReport();

                var categories_list = db.categories.Where(a=> a.valid == true)
                    .OrderBy(t => t.cat_name)
                    .ToList();
                var cat_all = new List<KeyValuePair<string, int>>();
                cat_all.Add(new KeyValuePair<string, int>("All", -1));
                foreach (var cat in categories_list)
                {
                    cat_all.Add(new KeyValuePair<string, int>(cat.cat_name, cat.cat_id));
                }

                this.cbCategory.DataSource = cat_all;
                this.cbCategory.SelectedIndex = 0;
                this.cbCategory.ValueMember = "Key";
                this.cbCategory.DisplayMember = "Key";
            }
        }

        private void BtnTeamResults_Click(object sender, EventArgs e)
        {
            string stringToInsert;

            // Define the string to insert
            using (var db = new klc01())
            {
                db.Database.CommandTimeout = 360;

                string cat = cbCategory.Text== "All" ? "" : cbCategory.Text;
                stringToInsert = db.get_results_json(cat).FirstOrDefault();
            }
            save_json(stringToInsert);
        }

        private void BtnCourseResults_Click(object sender, EventArgs e)
        {
            string stringToInsert;

            // Define the string to insert
            using (var db = new klc01())
            {
                db.Database.CommandTimeout = 360;
                stringToInsert = db.get_course_results_json("").FirstOrDefault();
            }
            save_json(stringToInsert);
        }

        public void save_json(string stringToInsert)
        { 
            OpenFileDialog openFileDialog1 = new OpenFileDialog
            {
                Title = "Browse Template File - ; html",

                CheckFileExists = true,
                CheckPathExists = true,

                DefaultExt = "html",
                Filter = "html files (*.html)|*.html|htm files (*.htm)|*.htm|All files (*.*)|*.*",
                FilterIndex = 1,
                RestoreDirectory = true,

                ReadOnlyChecked = true,
                ShowReadOnly = true
            };
            string templateFilePath = "";
            string templateContent = "";
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                templateFilePath = openFileDialog1.FileName;
                // Read the HTML template file
                templateContent = File.ReadAllText(templateFilePath);
            }

            string placeholder = "<!-- placeholder -->";
            string modifiedContent = templateContent.Replace(placeholder, stringToInsert);

            // Write the modified content back to the HTML file
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.Filter = "HTML Files|*.html;*.htm|All Files|*.*";

            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                string outputFilePath = saveFileDialog.FileName;
                File.WriteAllText(outputFilePath, modifiedContent);
                MessageBox.Show("Output saved successfully.", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void BtnRefresh_Click(object sender, EventArgs e)
        {
            List<results> results = null;
            int cat_id = 2;
            using (var db = new klc01())
            {
                results = db.results.Where(a => a.cat_id == cat_id).ToList();

                this.reportViewer1.LocalReport.ReportPath = "rpt_results.rdlc";
                this.reportViewer1.LocalReport.DataSources.Clear();
                ReportDataSource rdc = new ReportDataSource("ds_result", results);
                this.reportViewer1.LocalReport.DataSources.Add(rdc);

                this.reportViewer1.RefreshReport();
            }

        }

        private void btXMLresult_Click(object sender, EventArgs e)
        {
            // Write the modified content back to the HTML file
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.Filter = "XML Files|*.xml;*.htm|All Files|*.*";

            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                string outputFilePath = saveFileDialog.FileName;
                string utc_offset = NewCard.get_config_item("utc_offset") == "" ? @"+02:00" : NewCard.get_config_item("utc_offset");
                string str_time = NewCard.get_config_item("start_time") == "" ? @"2024-05-11 09:00:00.000" : NewCard.get_config_item("start_time");
                DateTime start_time = DateTime.ParseExact(str_time, "yyyy-MM-dd HH:mm:ss.fff", CultureInfo.InvariantCulture);
                DateTime end_time = start_time.AddHours(25);


                XmlWriterSettings settings = new XmlWriterSettings();
                settings.Indent = true;
                settings.IndentChars = "\t";
                settings.NewLineOnAttributes = true;
                //string file_name = "StartList.xml";

                using (XmlWriter writer = XmlWriter.Create(outputFilePath, settings))
                {
                    writer.WriteStartElement("ResultList", "http://www.orienteering.org/datastandard/3.0");
                    writer.WriteAttributeString("xmlns", "", null, "http://www.orienteering.org/datastandard/3.0");
                    writer.WriteAttributeString("xmlns", "xsi", null, "http://www.w3.org/2001/XMLSchema-instance");
                    writer.WriteAttributeString("iofVersion", "3.0");
                    writer.WriteAttributeString("createTime", DateTime.Now.ToString("yyyy-MM-ddTHH:mm:sszzz"));
                    writer.WriteAttributeString("creator", "h24");

                    writer.WriteStartElement("Event");
                    writer.WriteStartElement("Name");
                    writer.WriteString("h24");
                    writer.WriteEndElement();

                    writer.WriteStartElement("StartTime");
                    writer.WriteStartElement("Date");
                    writer.WriteString(start_time.ToString("yyyy-MM-dd"));
                    writer.WriteEndElement();//Date
                    writer.WriteStartElement("Time");
                    writer.WriteString(start_time.ToString("HH:mm:ss" + utc_offset));
                    writer.WriteEndElement();//Time
                    writer.WriteEndElement();//StartTime
                    writer.WriteStartElement("EndTime");
                    writer.WriteStartElement("Date");
                    writer.WriteString(end_time.ToString("yyyy-MM-dd"));
                    writer.WriteEndElement();//Date
                    writer.WriteStartElement("Time");
                    writer.WriteString(end_time.ToString("HH:mm:ss" + utc_offset));
                    writer.WriteEndElement();//Time
                    writer.WriteEndElement();//EndTime
                    writer.WriteEndElement();//Event

                    var db = new klc01();
                    db.Configuration.LazyLoadingEnabled = false;
                    db.Configuration.ProxyCreationEnabled = false;
                    List<v_iof_results> AllSlips = db.v_iof_results
/*                        .OrderBy(s => s.course_id)
                        .ThenBy(s => s.l_time)
                        .ThenBy(s => s.position ?? 99)*/
                        .ToList();

                    int course_id = 0;
                    int comp_id = 0;
                    int position = 0;
                    int i = 0;

                    foreach (var oneSlip in AllSlips)
                    {
                        Console.WriteLine($"slip ID: {oneSlip.slip_id}");
                        if (oneSlip.course_id != course_id)
                        {
                            if (i != 0)
                                writer.WriteEndElement();//ClassResult
                            writer.WriteStartElement("ClassResult");
                            writer.WriteStartElement("Class");
                            writer.WriteStartElement("Id");
                            writer.WriteValue(oneSlip.course_id);
                            writer.WriteEndElement();//Id
                            writer.WriteStartElement("Name");
                            writer.WriteValue(oneSlip.course_name);
                            writer.WriteEndElement();//Name
                            writer.WriteEndElement();//Class

                            writer.WriteStartElement("Course");
                            writer.WriteStartElement("Length");
                            writer.WriteValue(oneSlip.course_length);
                            writer.WriteEndElement();//Length
                            writer.WriteStartElement("Climb");
                            writer.WriteValue(oneSlip.course_climb ?? 0);
                            writer.WriteEndElement();//Climb
                            writer.WriteEndElement();//Course
                        }
                        if (oneSlip.comp_id != comp_id)
                        {
                            if (i != 0)
                            {
                                writer.WriteEndElement();//Result
                                writer.WriteEndElement();//PersonResult
                            }
                                
                            writer.WriteStartElement("PersonResult");
                            writer.WriteStartElement("Person");
                            writer.WriteStartElement("Id");
                            writer.WriteValue(oneSlip.comp_id);
                            writer.WriteEndElement();//Id
                            writer.WriteStartElement("Name");
                            writer.WriteStartElement("Family");
                            writer.WriteValue(oneSlip.comp_name);
                            writer.WriteEndElement();//Family
                            writer.WriteEndElement();//Name
                            writer.WriteEndElement();//Person

                            writer.WriteStartElement("Organisation");
                            writer.WriteStartElement("Id");
                            writer.WriteValue(oneSlip.team_id);
                            writer.WriteEndElement();//Id
                            writer.WriteStartElement("Name");
                            writer.WriteValue(oneSlip.team_name);
                            writer.WriteEndElement();//Name
                            writer.WriteEndElement();//Organisation

                            writer.WriteStartElement("Result");
                            writer.WriteStartElement("BibNumber");
                            writer.WriteValue(oneSlip.bib);
                            writer.WriteEndElement();//BibNumber
                            writer.WriteStartElement("StartTime");
                            writer.WriteValue(oneSlip.start_dtime);
                            writer.WriteEndElement();//StartTime
                            writer.WriteStartElement("FinishTime");
                            writer.WriteValue(oneSlip.finish_dtime);
                            writer.WriteEndElement();//FinishTime

                            writer.WriteStartElement("Time");
                            writer.WriteValue(oneSlip.l_time);
                            writer.WriteEndElement();//Time
                            writer.WriteStartElement("TimeBehind");
                            writer.WriteValue(oneSlip.t_behind);
                            writer.WriteEndElement();//TimeBehind

                            position++;
                            if(oneSlip.course_id != course_id)
                                position = 1;

                            writer.WriteStartElement("Position");
                            writer.WriteValue(position);
                            writer.WriteEndElement();//Position

                            writer.WriteStartElement("Status");
                            writer.WriteValue(oneSlip.leg_status);
                            writer.WriteEndElement();//Status

                            writer.WriteStartElement("Course");
                            writer.WriteStartElement("Id");
                            writer.WriteValue(oneSlip.course_id);
                            writer.WriteEndElement();//Id
                            writer.WriteStartElement("Name");
                            writer.WriteValue(oneSlip.course_name);
                            writer.WriteEndElement();//Name
                            writer.WriteStartElement("Length");
                            writer.WriteValue(oneSlip.course_length);
                            writer.WriteEndElement();//Length
                            writer.WriteStartElement("Climb");
                            writer.WriteValue(oneSlip.course_climb ?? 0);
                            writer.WriteEndElement();//Climb
                            writer.WriteEndElement();//Course
                        }
                        writer.WriteStartElement("SplitTime");
                        writer.WriteStartElement("ControlCode");
                        writer.WriteValue(oneSlip.control_code);
                        writer.WriteEndElement();//ControlCode
                        writer.WriteStartElement("Time");
                        writer.WriteValue(oneSlip.split_time);
                        writer.WriteEndElement();//Time
                        writer.WriteEndElement();//SplitTime

                        course_id = oneSlip.course_id;
                        comp_id = oneSlip.comp_id;

                        i++;

                        //

                    }
                    writer.WriteEndElement();//Result
                    writer.WriteEndElement();//PersonResult
//                    writer.WriteEndElement();//ClassResult
                    writer.Flush();
                    MessageBox.Show("Export copmlete");
                }
            }
        }
    }
}
