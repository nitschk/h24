using Microsoft.Reporting.WinForms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing.Imaging;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

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
            }
        }

        private void button1_Click(object sender, EventArgs e)
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
                Export(this.reportViewer1.LocalReport);
                //Print();
            }

        }

        private int m_currentPageIndex;
        private IList<Stream> m_streams;

        // Routine to provide to the report renderer, in order to
        //    save an image for each page of the report.
        private Stream CreateStream(string name, string fileNameExtension, Encoding encoding, string mimeType, bool willSeek)
        {
            Stream stream = new FileStream(@"..\..\" + name + "." + fileNameExtension, FileMode.Create);
            m_streams.Add(stream);
            return stream;
        }

        // Export the given report as an EMF (Enhanced Metafile) file.
        private void Export(LocalReport report)
        {
            string deviceInfo =
                "<DeviceInfo>" +
                "  <OutputFormat>EMF</OutputFormat>" +
                "  <PageWidth>8.5in</PageWidth>" +
                "  <PageHeight>11in</PageHeight>" +
                "  <MarginTop>0.25in</MarginTop>" +
                "  <MarginLeft>0.25in</MarginLeft>" +
                "  <MarginRight>0.25in</MarginRight>" +
                "  <MarginBottom>0.25in</MarginBottom>" +
                "</DeviceInfo>";
            Warning[] warnings;
            m_streams = new List<Stream>();
            report.Render("Image", deviceInfo, CreateStream, out warnings);
            foreach (Stream stream in m_streams)
                stream.Position = 0;
        }
        // Handler for PrintPageEvents
        private void PrintPage(object sender, PrintPageEventArgs ev)
        {
            Metafile pageImage = new Metafile(m_streams[m_currentPageIndex]);
            ev.Graphics.DrawImage(pageImage, ev.PageBounds);
            m_currentPageIndex++;
            ev.HasMorePages = (m_currentPageIndex < m_streams.Count);
        }

        private void Print()
        {
            const string printerName = "Microsoft Print to PDF";
            if (m_streams == null || m_streams.Count == 0)
                return;
            PrintDocument printDoc = new PrintDocument();
            printDoc.PrinterSettings.PrinterName = printerName;
            if (!printDoc.PrinterSettings.IsValid)
            {
                string msg = String.Format("Can't find printer \"{0}\".", printerName);
                MessageBox.Show(msg, "Print Error");
                return;
            }
            printDoc.PrintPage += new PrintPageEventHandler(PrintPage);
            printDoc.Print();
        }

        private void BtnJson_Click(object sender, EventArgs e)
        {
            string stringToInsert;

            // Define the string to insert
            using (var db = new klc01())
            {
                stringToInsert = db.get_results_json("").FirstOrDefault();
            }
            save_json(stringToInsert);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string stringToInsert;

            // Define the string to insert
            using (var db = new klc01())
            {
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

        private void button3_Click(object sender, EventArgs e)
        {
            using (var db = new klc01())
            {
                List<v_teams_results> results = db.v_teams_results.ToList();
                foreach(var result in results)
                {
                    //textBox1.Text += "\n" + result.res_pos + " " + result.team_nr + " " + result.team_name + " " + result.race_time + " " + result.legs_count;
                    textBox1.AppendText($"Team ID: {result.team_nr}, Team Name: {result.team_name}" + Environment.NewLine);

                }
            }
        }
    }
}
