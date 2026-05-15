using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Windows.Forms;


namespace h24
{
    public partial class frmCourses : Form
    {
        public frmCourses()
        {
            InitializeComponent();
        }

        klc01 db;

        private void btnBrowse_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog1 = new OpenFileDialog
            {
                Title = "Browse Course File - v8",

                CheckFileExists = true,
                CheckPathExists = true,

                DefaultExt = "txt",
                Filter = "txt files (*.txt)|*.txt",
                FilterIndex = 2,
                RestoreDirectory = true,

                ReadOnlyChecked = true,
                ShowReadOnly = true
            };

            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                tbCourseFile.Text = openFileDialog1.FileName;
            }
        }

        private void btnShow_Click(object sender, EventArgs e)
        {
            string textFile = tbCourseFile.Text;

            if (File.Exists(textFile))
            {
                // Read a text file line by line.  
                string[] lines = File.ReadAllLines(textFile);

                foreach (string line in lines)
                {
                    tbCourses.Text += line;
                    tbCourses.Text += "\n";
                }


            }
        }

        private void btnUpload_Click(object sender, EventArgs e)
        {
            string textFile = tbCourseFile.Text;

            int w = insertWdrnCourse();

            if (File.Exists(textFile))
            {
                // Read a text file line by line parsing:
                // SFa	5,1	20	S2-32-38-43-46-34-33-164-167-176-158-153-39-33-103-106-83-85-92-200-100-Z1
                // remove header before! courseName, courseLength, courseCount (not used), control-list
                string[] lines = File.ReadAllLines(textFile);

                // Parse excluded controls from tbExcludedControls only if cbExclude is checked
                List<string> excludedControls = this.cbExclude.Checked
                    ? this.tbExcludedControls.Text
                        .Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries)
                        .Select(c => c.Trim())
                        .ToList()
                    : new List<string>();

                foreach (string line in lines)
                {
                    string[] controls = line.Split(new string[] { "\t","-" }, StringSplitOptions.None);

                    int i = 0;
                    int k = 0;
                    string courseName = "";
                    float courseLength = 0;
                    int courseClimb = 0;

                    List<course_codes> controlCodes = new List<course_codes>();

                    using (var db = new klc01())
                    {

                        foreach (string control in controls)
                        {
                            course_codes cCode = new course_codes();
                            controls Cnt = new controls();

                            if (i == 0)
                            {
                                courseName = control;
                            }
                            else if (i == 1)
                            {
                                courseLength = float.Parse(control) * 1000;
                            }
                            else if (i == 4)
                            {
                                courseClimb = int.Parse(control, CultureInfo.InvariantCulture.NumberFormat);
                            }
                            else if ((i > 4) && (i % 2 == 1))
                            {
                                if (!excludedControls.Contains(control))
                                {
                                    cCode.control_id = control;
                                    cCode.position = k;
                                    cCode.as_of_date = DateTime.Now;
                                    controlCodes.Add(cCode);
                                    k++;
                                }

                                Cnt.control_id = control;
                                if (control == "Z1")
                                    Cnt.control_code = "F";
                                else
                                    Cnt.control_code = control;
                                Cnt.as_of_date = DateTime.Now;

                                //check if exists
                                if (db.controls.Find(Cnt.control_id) == null)
                                {
                                    db.controls.Add(Cnt);
                                    db.SaveChanges();
                                }
                            }
                            i++;
                        }

                        //save course and course_codes
                        var newCourse = new courses
                        {
                            course_name = courseName,
                            course_length = Convert.ToInt32(courseLength),
                            control_count = k,
                            course_climb = courseClimb,
                            as_of_date = DateTime.Now,
                            course_codes = controlCodes
                        };

                        db.courses.Add(newCourse);
                        db.SaveChanges();
                    }
                }
                dgCourses.DataSource = db.courses.ToList();
                MessageBox.Show("Courses uploaded");
            }
        }

        public int insertWdrnCourse()
        {
            db = new klc01();
            string wdrn_course = NewCard.get_config_item("wdrn_course");

            if (db.courses.Where(b => b.course_name == wdrn_course).Count() > 0)
            {
                return -1;
            }

            courses newCourse = new courses
            {
                course_name = wdrn_course,
                as_of_date = DateTime.Now
            };

            try
            {
                db.courses.Add(newCourse);
                db.SaveChanges();
                return 1;
            }
            catch (Exception)
            {
                MessageBox.Show("Error. Could not save WDRN course!");
                return 0;
            }
        }

        private void frmCourses_Load(object sender, EventArgs e)
        {
            db = new klc01();
            dgCourses.DataSource = db.courses.ToList();
        }

        private void dgCourses_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            db.SaveChanges();
        }

        private void dgCourses_SelectionChanged(object sender, EventArgs e)
        {
            int curRow = dgCourses.CurrentRow.Index;
            int course_id = Convert.ToInt32(dgCourses.Rows[curRow].Cells["course_id"].Value);
            db.Configuration.ProxyCreationEnabled = false;
            db.course_codes.Load();
            this.coursecodesBindingSource.DataSource = db.course_codes.Local.ToBindingList().Where(c => c.course_id == course_id);
        }

        private void dgControlCodes_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            db.SaveChanges();
        }

        private void BtnCheckCourses_Click(object sender, EventArgs e)
        {
            //string CourseList;
            using (var db = new klc01())
            {
                this.dgSameCourses.DataSource = db.sp_check_courses().ToList();

/*                var a = db.sp_check_courses().ToList();//.FirstOrDefault();
                if (a.Count() == 0)
                {
                    MessageBox.Show("OK");
                }
                else
                {
                    foreach(string crs in a)
                        CourseList = 
                    MessageBox.Show("Not OK", );
                }*/
            }

        }

        private void btDeleteCourses_Click(object sender, EventArgs e)
        {
            if (this.cbDelete.Checked)
            {
                using (var db = new klc01())
                {
                    db.Database.ExecuteSqlCommand("truncate table dbo.legs");
                    db.Database.ExecuteSqlCommand("truncate table dbo.course_codes");
                    db.Database.ExecuteSqlCommand("delete FROM dbo.courses");
                    this.dgCourses.Refresh();
                }
            }
            else
            {
                MessageBox.Show("No checkbox checked!");
            }
        }

    }
}
