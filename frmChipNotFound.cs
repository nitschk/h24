using System;
using System.Linq;
using System.Windows.Forms;

namespace h24
{
    public partial class frmChipNotFound : Form
    {
        klc01 db;
        public frmChipNotFound(string chip_id)
        {
            InitializeComponent();
            tbChipId.Text = chip_id;
        }

        private void frmChipNotFound_Load(object sender, EventArgs e)
        {
            db = new klc01();

            dgCompetitors.DataSource = db.v_comp_teams.ToList();
            dgCompetitors.Refresh();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void dgCompetitors_DoubleClick(object sender, EventArgs e)
        {
            int curRow = dgCompetitors.CurrentRow.Index;
            int comp_id = Convert.ToInt32(dgCompetitors.Rows[curRow].Cells["comp_id"].Value);
            this.update_chip(comp_id);
            this.Close();
        }

        private void btnAssign_Click(object sender, EventArgs e)
        {
            int curRow = dgCompetitors.CurrentRow.Index;
            int comp_id = Convert.ToInt32(dgCompetitors.Rows[curRow].Cells["comp_id"].Value);

            this.update_chip(comp_id);
            this.Close();
        }

        public void update_chip(int comp_id)
        {

            if (tbChipId.Text.Trim() == string.Empty || Int32.Parse(this.tbChipId.Text) < 1)
            {
                MessageBox.Show("Chip not filled");
                return;
            }
            int chip_id = Int32.Parse(this.tbChipId.Text);

            try
            {
                using (var db = new klc01())
                {
                    var result = db.competitors.SingleOrDefault(b => b.comp_id == comp_id);
                    if (result != null)
                    {
                        result.comp_chip_id = chip_id;
                        db.SaveChanges();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An exception occured: \n\n{ex.Message}.", "ReaderDemoProject", MessageBoxButtons.OK, MessageBoxIcon.Error);

            }
        }

        private void tbSearch_TextChanged(object sender, EventArgs e)
        {
            if (tbSearch.Text.Length > 0)
            {
                using (var db = new klc01())
                {
                    dgCompetitors.DataSource = db.sp_search_competitors(tbSearch.Text).ToList();
                    dgCompetitors.Refresh();
                }

            }

        }

        private void btClear_Click(object sender, EventArgs e)
        {
            this.tbSearch.Text = "";
            ActiveControl = this.tbSearch;
        }
    }
}
