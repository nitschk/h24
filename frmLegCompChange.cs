using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace h24
{
    public partial class frmLegCompChange : Form
    {
        int id_leg;
        klc01 db;
        public frmLegCompChange(int leg_id)
        {
            InitializeComponent();
            id_leg = leg_id;
        }

        private void btClear_Click(object sender, EventArgs e)
        {
            this.tbSearch.Text = "";
            ActiveControl = this.tbSearch;
        }

        private void btnAssign_Click(object sender, EventArgs e)
        {
            int curRow = dgCompetitors.CurrentRow.Index;
            int comp_id = Convert.ToInt32(dgCompetitors.Rows[curRow].Cells["comp_id"].Value);

            this.update_leg_comp(id_leg, comp_id);
            this.Close();
        }

        public void update_leg_comp(int leg_id, int comp_id)
        {
            try
            {
                using (var db = new klc01())
                {
                    var result = db.legs.SingleOrDefault(b => b.leg_id == leg_id);
                    if (result != null)
                    {
                        result.comp_id = comp_id;
                        db.SaveChanges();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An exception occured: \n\n{ex.Message}.", "ReaderDemoProject", MessageBoxButtons.OK, MessageBoxIcon.Error);

            }
        }

        private void frmLegCompChange_Load(object sender, EventArgs e)
        {
                db = new klc01();

                dgCompetitors.DataSource = db.v_comp_teams.ToList();

                /*            dgCompetitors.DataSource = db.competitors.Include(a => a.teams).ToList();

                            var result = (from c in competitors
                                          join t in teams
                                          on c.team_id equals t.team_id
                                          select new
                                          {
                                              c.comp_id,
                                              c.comp_name,
                                              c.bib,
                                              c.comp_chip_id,

                                          }).ToList();

                            dgCompetitors.DataSource = result;*/
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

            this.update_leg_comp(id_leg, comp_id);
            this.Close();
        }

        private void tbSearch_TextChanged(object sender, EventArgs e)
        {
            db = new klc01();
            string searchStr = this.tbSearch.Text;

            dgCompetitors.DataSource = db.v_comp_teams.Where(x => x.comp_name.Contains(searchStr)
            || x.bib.Contains(searchStr)
            || x.team_name.Contains(searchStr)
            ).ToList();
            dgCompetitors.Refresh();
        }
    }
}
