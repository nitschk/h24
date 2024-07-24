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
            }

        }

        private void BtnJson_Click(object sender, EventArgs e)
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

        private void button2_Click(object sender, EventArgs e)
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
    }
}
