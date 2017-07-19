using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using MySql.Data.MySqlClient;
using Microsoft.Reporting.WinForms;

namespace POSMainForm
{
    public partial class frmReporteVentas : Form
    {
        DateTime ReportDate;
        public frmReporteVentas(DateTime reportDate)
        {
            //Temporal to avoid login
            SQLConn.getData();
            //TODO: remove

            InitializeComponent();
            ReportDate = reportDate;
        }

        private void frmReporteVentas_Load(object sender, EventArgs e)
        {

            LoadReport();

        }
        private void LoadReport()
        {
            try
            {
                SQLConn.sqL = "SELECT T.InvoiceNo, ProductCode, P.Description, REPLACE(TDate, '-', '/') as TDate, TTime,TD.ItemPrice, TD.Quantity, SUM(TD.Quantity) as totalQuantity, (TD.ItemPrice * SUM(TD.Quantity)) as TotalPrice, P.UnitCost  FROM Product as P, Transactions as T, TransactionDetails as TD WHERE P.ProductNo = TD.ProductNo AND TD.InvoiceNo = T.InvoiceNo AND  TDate = '" + ReportDate.ToString("MM/dd/yyyy") + "' GROUP BY T.InvoiceNo, P.ProductNo, TDate ORDER By TDate";
                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);
                SQLConn.da = new MySqlDataAdapter(SQLConn.cmd);

                this.dataSetVentas1.VentasDiarias.Clear();
                SQLConn.da.Fill(this.dataSetVentas1.VentasDiarias);

                this.reportViewer1.SetDisplayMode(DisplayMode.PrintLayout);
                this.reportViewer1.ZoomPercent = 90;
                this.reportViewer1.ZoomMode = Microsoft.Reporting.WinForms.ZoomMode.Percent;

                this.reportViewer1.RefreshReport();

            }
            catch (Exception ex)
            {
                Interaction.MsgBox(ex.ToString());
            }
        }

      
    }
}
