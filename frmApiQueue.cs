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
    public partial class frmApiQueue : Form
    {
        private int currentRowIndex = -1;
        public frmApiQueue()
        {
            InitializeComponent();
            RefreshApiQueuel();
        }

        private void RefreshApiQueuel()
        {
            // Store the current row index
            StoreCurrentRowIndex();

            using (var db = new klc01())
            {
                var query = (from e in db.api_queue
                             join ql in db.api_queue_link on e.q_id equals ql.q_id
                             select new
                             {
                                 q_id = e.q_id,
                                 q_dtime = e.q_dtime,
                                 q_url = e.q_url,
                                 q_content = e.q_content,
                                 q_header = e.q_header,
                                 q_status = e.q_status,
                                 q_response = e.q_response,
                                 as_of_date = e.as_of_date,
                                 link_to = ql.link_to,
                                 link_id = ql.link_id
                             }
                             ).OrderByDescending(x => x.q_id).ToList();

                dgApiRequests.DataSource = query.ToList();
                dgApiRequests.Refresh();
                /*
                // Call your API to get new records
                var newRecords = query.ToList();

                // Assuming your DataGridView is named dataGridView1
                DataGridView dgv = dgApiRequests;

                // Clear existing rows
                dgv.Rows.Clear();

                // Add new records to the DataGridView
                foreach (var record in newRecords)
                {
                    // Add a new row to the DataGridView with the record data
                    dgv.Rows.Add(record.q_id, record.q_dtime, record.q_url, record.q_content, record.q_status,
                        record.q_response, record.as_of_date, record.link_to, record.link_id, record.q_header);
                }
                */
                // Restore the current row index
                RestoreCurrentRowIndex();

            }
        }

        private void brRefresh_Click(object sender, EventArgs e)
        {
            RefreshApiQueuel();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            RefreshApiQueuel();
        }

        private void cbRefresh_CheckedChanged(object sender, EventArgs e)
        {
            if (cbRefresh.Checked)
            {
                // Start the timer when the CheckBox is checked
                timer1.Start();
            }
            else
            {
                // Stop the timer when the CheckBox is unchecked
                timer1.Stop();
            }
        }

        // Store the current row index before refreshing
        private void StoreCurrentRowIndex()
        {
            if (dgApiRequests.CurrentRow != null)
            {
                currentRowIndex = dgApiRequests.CurrentRow.Index;
            }
        }

        // Restore the current row index after refreshing
        private void RestoreCurrentRowIndex()
        {
            if (currentRowIndex >= 0 && currentRowIndex < dgApiRequests.Rows.Count)
            {
                dgApiRequests.CurrentCell = dgApiRequests.Rows[currentRowIndex].Cells[0];
            }
        }
    }
}
