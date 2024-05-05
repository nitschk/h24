using System;
using System.Linq;
using System.Windows.Forms;

namespace h24
{
    public partial class frmLegs : Form
    {
        klc01 db;
        public frmLegs()
        {
            InitializeComponent();
        }

        private void btnGenerateLegs_Click(object sender, EventArgs e)
        {
            string prefix = txPrefix.Text;
            try
            {
                var a = db.sp_generate_legs(prefix);
                MessageBox.Show("Inserted: " + a.ToString());
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
            dgLegs.Refresh();

        }

        private void frmLegs_Load(object sender, EventArgs e)
        {
            try
            {
                using (db = new klc01())
                {
                    dgCourses.DataSource = db.courses.ToList();

                    legsBindingSource.DataSource = db.legs.ToList();
                    competitorsBindingSource.DataSource = db.competitors.ToList();
                    coursesBindingSource1.DataSource = db.courses.ToList();

                    cbCategory.DataSource = db.categories.ToList();
                    cbCategory.ValueMember = "cat_id";
                    cbCategory.DisplayMember = "cat_name";
                }

            }
            catch (Exception ex)
            {
                Console.Write("Error info:" + ex.Message);
            }
        }

        private void dgLegs_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            db.SaveChanges();
        }

        private void dgLegs_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {
            e.Cancel = true;
        }

        private void btDeleteLegs_Click(object sender, EventArgs e)
        {
            if (this.CbDeleteLegs.Checked)
                _ = NewCard.TruncateLegs();
        }

        private void btAssignFirstLeg_Click(object sender, EventArgs e)
        {
            string prefix = txPrefix.Text;
            int category = int.Parse(cbCategory.SelectedValue.ToString());
            if (prefix == "")
            {
                MessageBox.Show("No prefix filled!");
            }
            else
            {
                try
                {
                    using (db = new klc01())
                    {
                        var a = db.sp_legs_assign_first(prefix, category);
                        MessageBox.Show("Inserted: " + a.ToString());
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error: " + ex.Message);
                }
                dgLegs.Refresh();
            }
        }
    }
}
