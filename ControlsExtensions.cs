using System.Windows.Forms;

namespace h24
{
    public static class ControlsExtensions
    {
        public static DialogResult ShowDialogOnTop(this Form frm)
        {
            frm.TopMost = true;
            frm.Show();
            frm.TopMost = false;
            frm.Hide();
            return frm.ShowDialog();
        }
    }
}
