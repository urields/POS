using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using MySql.Data.MySqlClient;


namespace POSMainForm
{
    public partial class frmPOS : Form
    {       
        private void getConsecutive()
        {
            try
            {
                SQLConn.sqL = "SELECT InvoiceNo FROM posisdb_csharp.transactions ORDER BY InvoiceNo DESC LIMIT 1";
                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);
                SQLConn.dr = SQLConn.cmd.ExecuteReader();

                while (SQLConn.dr.Read() == true)
                {
                    InvoiceNo.Text = (int.Parse(SQLConn.dr["InvoiceNo"].ToString()) + 1).ToString();
                }
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

        private void fillDescriptComboBox(string strSearch)
        {
            try
            {
                SQLConn.sqL = "SELECT Description FROM Product WHERE Description LIKE '%" + strSearch + "%' ORDER BY Description DESC";
                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);
                SQLConn.dr = SQLConn.cmd.ExecuteReader();

                while (SQLConn.dr.Read() == true)
                {
                    comboBox2.Items.Add(SQLConn.dr["Description"].ToString());
                }
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

       public frmPOS()
        {
            InitializeComponent();            
        }

       public void NewTransaction()
       {
           ClearFields();
           getConsecutive();
       }

        private void frmPOS_Load(object sender, EventArgs e)
        {
            this.KeyUp+= new System.Windows.Forms.KeyEventHandler(KeyEvent);//To get F strokes
            getConsecutive();
            fillDescriptComboBox("");
            this.ActiveControl = this.comboBox2;
        }

        private void KeyEvent(object sender, KeyEventArgs e) //Keyup Event 
        {
            if (e.KeyCode == Keys.F1) //nueva Venta;
            {
                nuevaVenta(UserName, StaffID, Role);
            }
            if (e.KeyCode == Keys.F2) //Borrar Item
            {
                deleteSelectedItem();
            }
            if (e.KeyCode == Keys.F3) // Editar Item
            {
                editSelectedItem();
            }
            if (e.KeyCode == Keys.F4)
            {
                MessageBox.Show("Function F4");
            }
            if (e.KeyCode == Keys.F5) //Payment function
            {
                if (totalBox.Text == "") return; //nothing to pay.
                frmPayment fPy = new frmPayment(InvoiceNo.Text, double.Parse(totalBox.Text));
                fPy.Show();
            }
            if (e.KeyCode == Keys.F6) // cancelar Venta
            {
                NewTransaction();
            }
            if (e.KeyCode == Keys.F7)
            {
                MessageBox.Show("No hay Impresora Instalada");
            }

            /*else
                MessageBox.Show("No Function");*/

        }

        string UserName;
        int StaffID;
        string Role;

        public frmPOS(string UserName, int StaffID, string Role)
        {
            InitializeComponent();
            this.comboBox1.SelectedIndex = 0;
            this.ActiveControl = textBox1;

            //FILL THE COLABORATOR PANEL INFO
            this.UserName = UserName;
            this.StaffID = StaffID;
            this.Role = Role;
            this.textBox7.Text = UserName;
            this.textBox3.Text = StaffID.ToString();
            this.textBox8.Text = Role;
            //Temporal to avoid login
            SQLConn.getData();
            //TODO: remove
        }
  

        private void button1_Click(object sender, EventArgs e)
        {
            frmFilter fF = new frmFilter();
            fF.ShowDialog();
            if (fF.Codigo != null)
            {
                textBox1.Text = fF.barCode;
                textBox2.Text = fF.Codigo;
                comboBox2.Text = fF.Descripcion;
                textBox4.Text = fF.Precio;
                textBox5.Text = "1";
                textBox5.Focus();
                int total = int.Parse(textBox4.Text) * int.Parse(textBox5.Text);
                textBox6.Text = total.ToString();
            }
        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {
            //validate quanty MUST BE NUMERIC
            double Quantity;
            if (!double.TryParse(textBox5.Text, out Quantity) && textBox5.Text!="")
            {
                textBox5.Text = "";
                MessageBox.Show("Debes ingresar un Número");
                return;
            }


            if (textBox4.Text == "" || textBox5.Text == "")
            {
                textBox6.Text = "0";
            }
            else
            {
                if (this.comboBox1.SelectedIndex == 0) // by Quantity
                {
                float total = float.Parse(textBox4.Text) * float.Parse(textBox5.Text);
                textBox6.Text = total.ToString();
                }
                else // by Money
                {
                    textBox6.Text = textBox5.Text;
                }
               
            }
           
        }


        private bool AddItemToOrder()
        {
            try
            {
                float Discount = (float)0.0;
                //Lets fill the table item.
                ListViewItem x;
                x = new ListViewItem(textBox2.Text);
                x.SubItems.Add(comboBox2.Text);
                x.SubItems.Add(textBox4.Text); //P.U.

                if (this.comboBox1.SelectedIndex == 0) //Cantidad
                {
                    x.SubItems.Add(textBox5.Text); //Cantidad

                    //Sub_Total
                    //                      QTY                     P.U                                 DISCOUNT                
                    x.SubItems.Add((double.Parse(textBox5.Text) * float.Parse(textBox4.Text) * (1 - ((float)Discount / 100))).ToString());
                    //before update the list be sure to have enoguh inventory
                    if (!POS_DBQueries.checkExistences(textBox2.Text, double.Parse(textBox5.Text)))
                    {
                        MessageBox.Show("No hay suficientes existencias");
                        return false;
                    }
                }
                else //Importe
                {
                    double decQty = double.Parse(textBox5.Text) / double.Parse(textBox4.Text);
                    //x.SubItems.Add((Math.Truncate(decQty * 100) / 100).ToString()); //Cantidad
                    x.SubItems.Add(Strings.Format(decQty, "#,##0.00"));
                    //Sub_Total
                    //               QTY                     P.U                                 DISCOUNT                
                    x.SubItems.Add((decQty * float.Parse(textBox4.Text) * (1 - ((float)Discount / 100))).ToString());
                    //before update the list be sure to have enoguh inventory
                    if (!POS_DBQueries.checkExistences(textBox2.Text, decQty))
                    {
                        MessageBox.Show("No hay suficientes existencias");
                        return false;
                    }

                }

                listView1.Items.Add(x);
                comboBox1.SelectedItem = 0; //reset to Qty Sales.

                // update TOTAL
                float accum = 0;
                int accumItems = 0;
                foreach (ListViewItem item in listView1.Items)
                {
                    if (double.Parse(item.SubItems[3].Text.ToString()) % 1 == 0) //is integer
                    {
                        accumItems += int.Parse(item.SubItems[3].Text.ToString());
                    }
                    else// is Decimal
                    {
                        accumItems += 1;
                    }

                    accum += float.Parse(item.SubItems[4].Text.ToString());
                }
                numItems.Text = accumItems.ToString();
                totalBox.Text = accum.ToString();
            }
            catch(Exception e)
            {
                MessageBox.Show("SELECCIONA UN PRODUCTO VALIDO");
                return false;
            } 
            
            return true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (AddItemToOrder())
            {
                foreach (Control ctr in groupBox1.Controls)
                {
                    if (ctr is TextBox)
                    {
                        ctr.Text = "";
                    }
                }
                comboBox1.SelectedIndex = 0;
               
                comboBox2.Text = "";
                this.ActiveControl = comboBox2;
            }
            else
            {
                this.ActiveControl = textBox5; // not enough inventory set Qty active again.
            }
        }



        private void button7_Click(object sender, EventArgs e) //payment Button
        {
            if (totalBox.Text == "") return; //nothing to pay.
            frmPayment fPy = new frmPayment(InvoiceNo.Text, double.Parse(totalBox.Text));
            fPy.Show();
        }


        public void StockOut()
        {
            try
            {               
                double numProds;
                string ProdCode;
                foreach (ListViewItem item in listView1.Items)
                {
                    ProdCode = item.SubItems[0].Text; 
                    numProds = double.Parse(item.SubItems[3].Text.ToString());

                SQLConn.sqL = @"UPDATE product SET  StocksOnHand = StocksOnHand - '"
                              + numProds + @"' WHERE ProductNo = ( SELECT ProductNo FROM  (SELECT * FROM posisdb_csharp.product) AS P
                                WHERE ProductCode = '" + ProdCode + "')";
                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);
                SQLConn.cmd.ExecuteNonQuery();
                }
               // Interaction.MsgBox("Product successfully Updated.", MsgBoxStyle.Information, "Update Product");
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


        public void AddTransaction(){

            try
            {
                SQLConn.sqL = "INSERT INTO transactions (TDate,TTime,NonVatTotal,VatAmount,TotalAmount,StaffID) VALUES ('" + System.DateTime.Now.ToString("MM/dd/yyyy") + "','" + DateTime.Now.ToString("HH:mm:ss tt") + "','"+ totalBox.Text +"',0,'"+ totalBox.Text +"',1)";                
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


        public void AddTransactionDetails()
        {
            try
            {
                double Qty;
                double Dscnt;
                string ProdCode;
                foreach (ListViewItem item in listView1.Items)
                {
                ProdCode = item.SubItems[0].Text;
                Dscnt = 0.0;//double.Parse(item.SubItems[3].Text.ToString());   
                Qty= double.Parse(item.SubItems[3].Text.ToString());

                SQLConn.sqL = @"INSERT INTO transactiondetails (InvoiceNo, ProductNo, ItemPrice , Quantity, Discount)
                                SELECT 
                                        (SELECT InvoiceNo 
                                        FROM posisdb_csharp.transactions 
                                        ORDER BY InvoiceNo DESC LIMIT 1 
                                        )
                                , P.ProductNo, P.UnitPrice, '" + Qty + @"', '" + Dscnt + @"'   
                                FROM  posisdb_csharp.product as P
                                WHERE P.ProductCode= '" + ProdCode + "'";

                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);
                SQLConn.cmd.ExecuteNonQuery();
                }
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

     

       
        //BARCODE Search
        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            if (textBox1.Focused)
            {
                SQLConn.strSearch = textBox1.Text;
                if (SQLConn.strSearch.Length >= 1)
                {
                    List<ProdRecords> DRecords = new List<ProdRecords>();
                    DRecords = POS_DBQueries.LoadFromBARCODE(SQLConn.strSearch.Trim());
                    if (DRecords.Count > 0)
                    {
                        textBox2.Text = DRecords[0].ProductCode;
                        comboBox2.Text = DRecords[0].Description;
                        textBox4.Text = DRecords[0].UnitPrice;
                        textBox5.Text = "1";
                        this.ActiveControl = textBox5;
                    }
                    else
                    {
                        MessageBox.Show("No existe ningun producto con este Código");
                        this.ActiveControl = textBox2;
                    }                    
                }
            }
        }


        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Tab)
            {
                comboBox2.Focus();
            }
        }

        public void ClearFields()           
        {
            foreach (Control ctr in groupBox1.Controls) //item Controls
            {
                if (ctr is TextBox)
                {
                    ctr.Text = "";
                }
            }
            comboBox2.Text = "";       

            foreach (Control ctr in groupBox6.Controls)// total controls
            {
                if (ctr is TextBox)
                {
                    ctr.Text = "";
                }
            }    
            listView1.Items.Clear();
            this.ActiveControl = textBox1;
        }

        //PRODCODE LOAD
        private void textBox2_KeyDown(object sender, KeyEventArgs e) //by CodeSearch enter
        {
            if (e.KeyCode == Keys.Enter)
            {
                SQLConn.strSearch = textBox2.Text;

                if (SQLConn.strSearch.Length >= 1)
                {
                    List<ProdRecords> DRecords = new List<ProdRecords>();
                    DRecords = POS_DBQueries.LoadFromPRODCODE(SQLConn.strSearch.Trim());
                    if (DRecords.Count > 0)
                    {
                        textBox1.Text = DRecords[0].Barcode;
                        comboBox2.Text = DRecords[0].Description;
                        textBox4.Text = DRecords[0].UnitPrice;
                        textBox5.Text = "1";
                        this.ActiveControl = textBox5;
                    }
                    else
                    {
                        MessageBox.Show("No existe ningun producto con este Código");
                        this.ActiveControl = textBox2;
                    }

                }
                
            }

        }

       

    // QtyBox Enter
        private void textBox5_KeyDown(object sender, KeyEventArgs e) 
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (AddItemToOrder())
                {
                    foreach (Control ctr in groupBox1.Controls)
                    {
                        if (ctr is TextBox)
                        {
                            ctr.Text = "";
                        }
                    }
                    comboBox1.SelectedIndex = 0;
                    this.comboBox2.Text = "";
                    this.ActiveControl = comboBox2;
                }
                else
                {
                    this.ActiveControl = textBox5; // not enough inventory set Qty active again.
                }

                
            }

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex == 1) // Importe
            {
                this.label6.Visible = true;
                this.textBox5.Focus();
                if (this.textBox5.Text!="")
                this.textBox6.Text = this.textBox5.Text;
            }
            else
            {
                this.label6.Visible = false;
            }
        }

        private void editSelectedItem()
        {
            if (listView1.Items.Count == 0)
            {
                Interaction.MsgBox("Seleciona el producto a editar", MsgBoxStyle.Exclamation, "Borrar");
                return;
            }
            double Discount = 0.0;
            for (int i = 0; i < listView1.Items.Count; i++)
            {
                if (listView1.Items[i].Selected)
                {
                    string NewNumItems = Interaction.InputBox("Ingresa nueva cantidad", "1", "1");
                    double NewNumItemsASDob=0;
                    try
                    {
                        NewNumItemsASDob=double.Parse(NewNumItems);
                    }catch(Exception e){
                        MessageBox.Show("El número de items es incorrecto, verifiquelo por favor.");
                    }

                    if (POS_DBQueries.checkExistences(listView1.Items[i].SubItems[0].Text, NewNumItemsASDob))
                    {
                        listView1.Items[i].SubItems[3].Text = NewNumItems;
                        listView1.Items[i].SubItems[4].Text = ((double.Parse(NewNumItems) * float.Parse(listView1.Items[i].SubItems[2].Text) * (1 - ((float)Discount / 100))).ToString());
                    }
                    else
                    {
                        MessageBox.Show("No hay suficientes existencias");
                    }
                    break;
                }
            }

            //UPDATE TOTALS
            float accum = 0;
            int accumItems = 0;
            foreach (ListViewItem item in listView1.Items)
            {
                if (double.Parse(item.SubItems[3].Text.ToString()) % 1 == 0) //is integer
                {
                    accumItems += int.Parse(item.SubItems[3].Text.ToString());
                }
                else// is Decimal
                {
                    accumItems += 1;
                } 
                accum += float.Parse(item.SubItems[4].Text.ToString());
            }
            numItems.Text = accumItems.ToString();
            totalBox.Text = accum.ToString();
        }

        private void deleteSelectedItem()
        {
            if (listView1.Items.Count == 0)
            {
                Interaction.MsgBox("Seleciona el producto a borrar", MsgBoxStyle.Exclamation, "Borrar");
                return;
            }
            for (int i = 0; i < listView1.Items.Count; i++)
            {
                if (listView1.Items[i].Selected)
                {
                    listView1.Items[i].Remove();
                    break;
                }
            }

            //UPDATE TOTALS
            float accum = 0;
            int accumItems = 0;
            foreach (ListViewItem item in listView1.Items)
            {               
                if (double.Parse(item.SubItems[3].Text.ToString()) % 1 == 0) //is integer
                {
                    accumItems += int.Parse(item.SubItems[3].Text.ToString());
                }
                else// is Decimal
                {
                    accumItems += 1;
                }
                accum += float.Parse(item.SubItems[4].Text.ToString());
            }
            numItems.Text = accumItems.ToString();
            totalBox.Text = accum.ToString();
                
           
        }

        private void button5_Click(object sender, EventArgs e) //DeleteItem
        {
            deleteSelectedItem();
        }


        private void nuevaVenta(string UserName, int StaffID, string Role)
        {
            frmPOS m = new frmPOS(UserName,StaffID,Role);
            m.StartPosition = FormStartPosition.Manual;
            m.Left = 0;
            m.Top = 0;
            m.Show();
        }

        private void button3_Click(object sender, EventArgs e) // NEW SALE
        {
            nuevaVenta(UserName, StaffID, Role);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            MessageBox.Show("No autorizado");
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox2.Focused)
            {
                SQLConn.strSearch = comboBox2.Text;
                if (SQLConn.strSearch.Length >= 1)
                {

                    List<ProdRecords> DRecords = new List<ProdRecords>();
                    DRecords = POS_DBQueries.LoadFromDESCRIPTION(SQLConn.strSearch.Trim());
                    if (DRecords.Count > 0)
                    {
                        textBox1.Text = DRecords[0].Barcode;
                        textBox2.Text = DRecords[0].ProductCode;
                        //comboBox2.Text = DRecords[0].Description;
                        textBox4.Text = DRecords[0].UnitPrice;
                        textBox5.Text = "1";
                        float total = float.Parse(textBox4.Text) * float.Parse(textBox5.Text);
                        textBox6.Text = total.ToString();
                        this.ActiveControl = textBox5;
                    }
                    else
                    {
                        MessageBox.Show("No existe ningun producto con este Código");
                        this.ActiveControl = textBox2;
                    }
   
                }                
               
            }

        }

        private void button8_Click(object sender, EventArgs e) //Cancelar Venta.
        {
            NewTransaction();
        }

        private void button6_Click(object sender, EventArgs e) //editar items
        {
            editSelectedItem();
        }
    }
}
