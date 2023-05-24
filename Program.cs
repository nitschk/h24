using System;
using System.Threading;
using System.Windows.Forms;

namespace h24
{
  static class Program
  {
    /// <summary>
    /// Der Haupteinstiegspunkt für die Anwendung.
    /// </summary>
    [STAThread]
    static void Main()
    {
      Application.EnableVisualStyles();
      Application.SetCompatibleTextRenderingDefault(false);
      Application.ThreadException += new ThreadExceptionEventHandler(HandleUnhandledException);
      Application.Run(new FrmMain());
    }


    private static void HandleUnhandledException(object sender, ThreadExceptionEventArgs e)
    {
      MessageBox.Show($"Neodchycená vyjimka:\n{e.Exception.Message}\n{e.Exception.StackTrace}");
    }
  }
}
