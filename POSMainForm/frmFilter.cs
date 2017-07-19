using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using MySql.Data.MySqlClient;


using Microsoft.VisualBasic;


namespace POSMainForm
{
    public partial class frmFilter : Form
    {
        public string barCode { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public string Precio { get; set; }

        public frmFilter()
        {
            InitializeComponent();
            LoadProducts("");
            comboBox1.SelectedIndex = 0;
        }

        public void LoadProducts(string strSearch)
        {
            try
            {
                SQLConn.sqL = "SELECT BarCode, ProductCode AS Código, P.Description AS Descripcion, UnitPrice AS Precio, StocksOnHand AS Stock,  CategoryName FROM Product as P LEFT JOIN Category C ON P.CategoryNo = C.CategoryNo WHERE P.Description LIKE '%" + strSearch + "%' ORDER BY P.CategoryNo";
                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);

                SQLConn.dr = SQLConn.cmd.ExecuteReader();
                ListViewItem x = null;
                listView1.Items.Clear();

                while (SQLConn.dr.Read() == true)
                {
                    x = new ListViewItem(SQLConn.dr["BarCode"].ToString());
                    x.SubItems.Add(SQLConn.dr["Código"].ToString());
                    x.SubItems.Add(SQLConn.dr["Descripcion"].ToString());
                    x.SubItems.Add(SQLConn.dr["Precio"].ToString());
                    x.SubItems.Add(SQLConn.dr["Stock"].ToString());
                    x.SubItems.Add(SQLConn.dr["CategoryName"].ToString());
                    listView1.Items.Add(x);
                }

                /*DataTable dataTable = new DataTable();
                MySqlDataAdapter dataAdapter = new MySqlDataAdapter(SQLConn.cmd);
                dataAdapter.Fill(dataTable);
                dataGridView1.DataSource = dataTable; */                 
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


        private void button1_Click(object sender, EventArgs e)
        {
            SQLConn.strSearch = textBox1.Text;

            if (SQLConn.strSearch.Length >= 1)
            {
                LoadProducts(SQLConn.strSearch.Trim());
            }
            else if (string.IsNullOrEmpty(SQLConn.strSearch))
            {
                LoadProducts("");
                //return;
            }
        }

        private void listView1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                this.barCode = listView1.FocusedItem.Text;
                this.Codigo = listView1.FocusedItem.SubItems[1].Text;
                this.Descripcion = listView1.FocusedItem.SubItems[2].Text;
                this.Precio = listView1.FocusedItem.SubItems[3].Text;
                this.Close();
            }
            
        }    

       /* private void dataGridView1_DoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            this.barCode = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[0].Value.ToString();
            this.Codigo = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[1].Value.ToString();
            this.Descripcion = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[2].Value.ToString();
            this.Precio = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[3].Value.ToString();            
            this.Dispose();           
        }*/

        private void listView1_DoubleClick(object sender, EventArgs e)
        {
            this.barCode = listView1.FocusedItem.Text;
            this.Codigo = listView1.FocusedItem.SubItems[1].Text;
            this.Descripcion= listView1.FocusedItem.SubItems[2].Text;
            this.Precio = listView1.FocusedItem.SubItems[3].Text;
            this.Close();
        }

       /* private void dataGridView1_PreviewKeyDown(object sender, PreviewKeyDownEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                this.barCode = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[0].Value.ToString();
                this.Codigo = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[1].Value.ToString();
                this.Descripcion = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[2].Value.ToString();
                this.Precio = dataGridView1.Rows[dataGridView1.SelectedCells[0].RowIndex].Cells[3].Value.ToString();
                this.Dispose();  

                //int i = dataGridView1.CurrentRow.Index;
                //MessageBox.Show(i.ToString());
            }
        }*/


        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            SQLConn.strSearch = textBox1.Text;

            if (SQLConn.strSearch.Length >= 1)
            {
                LoadProducts(SQLConn.strSearch.Trim());
            }
            else if (string.IsNullOrEmpty(SQLConn.strSearch))
            {
                LoadProducts("");
                //return;
            } 
        }

        private void frmFilter_Load(object sender, EventArgs e)
        {
            this.KeyUp += new System.Windows.Forms.KeyEventHandler(KeyEvent);//To get strokes
        }
        private void KeyEvent(object sender, KeyEventArgs e) //Keyup Event 
        {
            if (e.KeyCode == Keys.Left ||
                e.KeyCode == Keys.Right ||
                e.KeyCode == Keys.Up ||
                e.KeyCode == Keys.Down) //nueva Venta;
            {
                //this.ActiveControl = this.dataGridView1;
            }
        }

    
    }
}
