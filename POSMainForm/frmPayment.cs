using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Diagnostics;
using System.Windows.Forms;
using System.Linq;
using System.Xml.Linq;
using MySql.Data.MySqlClient;

namespace POSMainForm
{
    public partial class frmPayment : Form
    {
        string InvoiceNo;
        double TotalAmount;
        public frmPayment(string invoiceNo, double totalAmount)
        {
            InitializeComponent();
            InvoiceNo = invoiceNo;
            TotalAmount = totalAmount;
        }

        private void AddPayment()
        {
            try
            {
                SQLConn.sqL = "INSERT INTO PAYMENT(InvoiceNo, Cash, PChange) VALUES('" + InvoiceNo + "', '" + txtCash.Text.Replace(",", "") + "', '" + txtChange.Text.Replace(",", "") + "')";
                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);
                SQLConn.cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Interaction.MsgBox(ex.ToString());
            }
            finally
            {
                SQLConn.cmd.Dispose();
                SQLConn.conn.Close();
            }
        }

        private void frmPayment_Load(System.Object sender, System.EventArgs e)
        {
            this.Location = new Point(515, 470);
            txtTA.Text = Strings.FormatNumber(TotalAmount).ToString(); 
            txtCash.Text = "";
        }


        private void PayANDRenew()
        {
            double TotalAmount=0;
            double cash=0;
            try
            {
                TotalAmount = Convert.ToDouble(txtTA.Text.Replace(",", ""));
                cash = Convert.ToDouble(txtCash.Text.Replace(",", ""));
                if (TotalAmount > cash)
                {
                    Interaction.MsgBox("El efectivo es Insuficiente para liquidar", MsgBoxStyle.Exclamation, "Pago");
                    txtCash.Focus();
                }
                else
                {
                    AddPayment();
                    if (System.Windows.Forms.Application.OpenForms["frmPOS"] != null)
                    {
                        frmPOS p = (System.Windows.Forms.Application.OpenForms["frmPOS"] as frmPOS);
                        p.AddTransaction();
                        p.AddTransactionDetails();
                        p.StockOut();

                        //  frmPrintReceipt pr = new frmPrintReceipt(InvoiceNo);
                        //  pr.Show();

                        Interaction.MsgBox("Transaction completed.", MsgBoxStyle.Information, "Transaction");
                        p.NewTransaction();
                        this.Close();
                    }

                    //My.MyProject.Forms.frmPrintReceipt.Show();

                    this.Close();
                }
            }
            catch (Exception e)
            {
                MessageBox.Show("El efectivo es invalido.");
            }
            
        }

        private void button1_Click(object sender, EventArgs e) // OK button
        {
            PayANDRenew();
        }

        private void txtCash_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
        {
            if (e.KeyChar == ControlChars.Cr)
            {
                PayANDRenew();
            }
        }


        private void frmPayment_KeyDown(object sender, KeyEventArgs e)
        {
               if( e.KeyCode == Keys.Escape) this.Close();
        }

        private void frmPayment_Load_1(object sender, EventArgs e)
        {
            this.Location = new Point(515, 400);
            txtTA.Text = Strings.FormatNumber(TotalAmount);
            txtCash.Text = "";
        }

        private void txtCash_TextChanged(object sender, EventArgs e)
        {
            txtChange.Text = Strings.Format(Conversion.Val(txtCash.Text.Replace(",", "")) - Conversion.Val(txtTA.Text.Replace(",", "")), "#,##0.00");
        }

       
    }
}
