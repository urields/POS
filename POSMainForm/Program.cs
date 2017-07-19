using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace POSMainForm
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new frmLogin());
            //Application.Run(new frmPOS("me",0,"admin"));           

            /*string date = "21/04/2017";
            DateTime dt = Convert.ToDateTime(date);
            Application.Run(new frmReporteVentas(dt));*/

            //Application.Run(new frmReportDailSalesByInvoice(DateTime.Now));
            
        }
    }
}
