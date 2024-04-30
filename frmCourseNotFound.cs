using System;
using System.Data;
using System.Linq;
using System.Windows.Forms;

namespace h24
{
    public partial class frmCourseNotFound : Form
    {
        klc01 db;
        public int course;
        public int prv_course;

        public frmCourseNotFound(int competitor_id, int readout_id, int previous_course)
        {
            InitializeComponent();
            this.label3.Text = this.competitorDetail(competitor_id) + readout_id.ToString();
            this.label4.Text = this.courseDetail(previous_course);
            prv_course = previous_course;

        }

        private string competitorDetail(int competitor_id)
        {
            db = new klc01();
            var oneCompetitor = db.competitors.FirstOrDefault(c => c.comp_id == competitor_id);
            return oneCompetitor.bib + " - " + oneCompetitor.comp_name + " Chip: " + oneCompetitor.comp_chip_id;
        }

        private string courseDetail(int course_id)
        {
            db = new klc01();
            var oneCourse = db.courses.FirstOrDefault(c => c.course_id == course_id);
            return oneCourse == null ? "": "Previously selected course: " + oneCourse.course_name ?? "N/A";
        }

        private void frmCourseNotFound_Load(object sender, EventArgs e)
        {
            db = new klc01();
            dgCourses.DataSource = db.courses.OrderBy(x=>x.course_name).ToList();

            DataGridViewRow row = dgCourses.Rows
                .Cast<DataGridViewRow>()
                .FirstOrDefault(r => Convert.ToInt32(r.Cells["course_id"].Value) == prv_course);

            if (row != null)
            {
                // Select the row
                row.Selected = true;

                // Optionally, you can scroll to the selected row
                dgCourses.FirstDisplayedScrollingRowIndex = row.Index;
            }
        }

        private void dgCourses_ColumnWidthChanged(object sender, DataGridViewColumnEventArgs e)
        {
            Properties.Settings.Default.dgCourses_course_name = dgCourses.Columns["course_name"].Width;
            Properties.Settings.Default.dgCourses_course_length = dgCourses.Columns["course_length"].Width;
            Properties.Settings.Default.dgCourses_course_climb = dgCourses.Columns["course_climb"].Width;
            Properties.Settings.Default.dgCourses_control_count = dgCourses.Columns["control_count"].Width;

            Properties.Settings.Default.Save();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {

            int curRow = this.dgCourses.CurrentRow.Index;
            course = Convert.ToInt32(this.dgCourses.Rows[curRow].Cells["course_id"].Value);

            this.Close();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            course = 0;
            this.Close();
        }

        private void txSearch_TextChanged(object sender, EventArgs e)
        {
            if (txSearch.Text.Length > 0)
            {
                using (var db = new klc01())
                {
                    var query = from c in db.courses
                                where c.course_name.Contains(txSearch.Text)
                                select c;
                    dgCourses.DataSource = //query.ToList();
                    query.OrderBy(x => x.course_name).ToList();
                    dgCourses.Refresh();
                }

            }
        }

        private void btClear_Click(object sender, EventArgs e)
        {
            this.txSearch.Text = "";
            ActiveControl = this.txSearch;
        }

        private void dgCourses_DoubleClick(object sender, EventArgs e)
        {
            int curRow = this.dgCourses.CurrentRow.Index;
            course = Convert.ToInt32(this.dgCourses.Rows[curRow].Cells["course_id"].Value);
            this.Close();
        }
    }
}
