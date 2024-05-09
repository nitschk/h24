using Microsoft.Reporting.WinForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;


namespace h24
{
    public partial class FrmStatusChange : Form
    {
        int leg_id;
        bool post_slip;
        int readout_id;
        bool form_dirty = false;
        public FrmStatusChange(int id_leg, bool postSlip )
        {
            InitializeComponent();
            leg_id = id_leg;
            post_slip = postSlip;
        }

        private void FrmStatusChange_Load(object sender, EventArgs e)
        {
            RefreshSlip();
            using (var db = new klc01())
            {
                legs leg = db.legs.Where(a => a.leg_id == leg_id).FirstOrDefault();
                tbPenalty.Text = leg.dsk_penalty.ToString();
                if (!string.IsNullOrEmpty(leg.leg_status))
                {
                    // Select the status in the combo box
                    cmStatus.SelectedItem = leg.leg_status;
                }
            }

        }

        public void RefreshSlip()
        {
            using (var db = new klc01())
            {
                List<slips> slip = db.slips.Where(a => a.leg_id == leg_id).ToList();

                this.reportViewer1.LocalReport.ReportPath = "rptSlip1.rdlc";
                this.reportViewer1.LocalReport.DataSources.Clear();
                ReportDataSource rdc = new ReportDataSource("dsSlip", slip);
                this.reportViewer1.LocalReport.DataSources.Add(rdc);
                //this.reportViewer1.LocalReport.Refresh();

                this.reportViewer1.RefreshReport();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            RefreshSlip();
        }

        private void btClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btSave_Click(object sender, EventArgs e)
        {
            int i;
            using (var db = new klc01())
            {
                legs leg = db.legs.Where(a => a.leg_id == leg_id).FirstOrDefault();
                int competitor_id = leg.comp_id;
                readout_id = (int)leg.readout_id;
                leg.dsk_penalty = TimeSpan.Parse(tbPenalty.Text);
                leg.leg_status = cmStatus.SelectedItem?.ToString();
                db.SaveChanges();

                //add/update leg_exception
                var newExc = new leg_exceptions
                {
                    leg_id = leg_id,
                    ex_leg_status = cmStatus.SelectedItem?.ToString(),
                    ex_dsk_penalty = TimeSpan.Parse(tbPenalty.Text),
                    as_of_date = DateTime.Now,
                };
                db.Set<leg_exceptions>().AddIfNotExists(newExc, x => x.leg_id == leg_id);
                i = db.SaveChanges();

                //
                NewCard NewCard = new NewCard();
                int y = NewCard.UpdateTeamRaceEnd(competitor_id);
                int slip_id = NewCard.InsertSlip(leg_id);
                form_dirty = true;
                /*if (post_slip)
                {
                    var result = await NewCard.PostSlip(readout_id);
                }*/
            }
            RefreshSlip();
        }

        private async void FrmStatusChange_FormClosing(object sender, FormClosingEventArgs e)
        {
            NewCard NewCard = new NewCard();
            if (post_slip && form_dirty)
            {
                var result = await NewCard.PostSlip(readout_id);
            }
        }
    }
}
