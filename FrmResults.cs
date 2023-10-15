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
            using (var db = new klc01())
            {
                // Create a StreamWriter to the output file.
                var fileStream = new StreamWriter("team_results.json");

                string results;
                // Execute the stored procedure and get the results.
                results = db.get_results_json("").FirstOrDefault();
                fileStream.WriteLine(results.ToString());

                // Close the StreamWriter.
                fileStream.Close();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            using (var db = new klc01())
            {
                // Create a StreamWriter to the output file.
                var fileStream = new StreamWriter("course_results.json");

                string results;
                // Execute the stored procedure and get the results.
                results = db.get_course_results_json("").FirstOrDefault();
                fileStream.WriteLine(results.ToString());

                // Close the StreamWriter.
                fileStream.Close();
                MessageBox.Show("Done");
            }
        }
    }
}