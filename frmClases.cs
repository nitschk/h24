using System;
using System.Linq;
using System.Windows.Forms;

namespace h24
{
    public partial class frmClases : Form
    {
        klc01 db;

        public frmClases()
        {
            InitializeComponent();
        }

        private void dgCategories_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            db.SaveChanges();
        }

        private void frmClases_Load(object sender, EventArgs e)
        {
            db = new klc01();

            dgCategories.DataSource = db.categories.ToList();
        }
    }
}
