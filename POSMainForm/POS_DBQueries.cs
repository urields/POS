using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.VisualBasic;
using MySql.Data.MySqlClient;

namespace POSMainForm
{
    public class ProdRecords
    {
        public string Barcode { get; set; }
        public string ProductCode { get; set; }
        public string Description { get; set; }
        public string UnitPrice { get; set; }
    }

    class POS_DBQueries 
    {        
        public static bool checkExistences(String ProdCode, double required)
        {
            double available = 0.0;
            try
            {
                SQLConn.sqL = "SELECT StocksOnHand FROM Product as P WHERE P.ProductCode = '" + ProdCode + "'";
                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);
                SQLConn.dr = SQLConn.cmd.ExecuteReader();
                if (SQLConn.dr.Read())
                {
                    available = double.Parse(SQLConn.dr["StocksOnHand"].ToString());
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

            if (available >= required)
            {
                return true;
            }
            return false;
        }

       
        public static List<ProdRecords> LoadFromPRODCODE(string ProdCode)
        {
            //Temporal to avoid login
            SQLConn.getData();
            //TODO: remove

            List<ProdRecords> DRecords = new List<ProdRecords>();
            try
            {
                SQLConn.sqL = "SELECT Barcode, Description, UnitPrice, StocksOnHand from Product WHERE ProductCode = '" + ProdCode + "'";
                //SQLConn.sqL = "SELECT Barcode, Description, UnitPrice, StocksOnHand FROM Product as P WHERE P.ProductCode = '" + ProdCode + "'";
                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);
                SQLConn.dr = SQLConn.cmd.ExecuteReader();
            
                if (SQLConn.dr.Read())
                {
                    DRecords.Add(new ProdRecords()
                    {
                        Barcode = SQLConn.dr["Barcode"].ToString(),
                        Description = SQLConn.dr["Description"].ToString(),
                        UnitPrice = SQLConn.dr["UnitPrice"].ToString()
                    });

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
            return DRecords;
        }


        public static List<ProdRecords> LoadFromDESCRIPTION(string Description)
        {
            List<ProdRecords> DRecords = new List<ProdRecords>();
            try
            {
                SQLConn.sqL = "SELECT BarCode, ProductCode, Description, UnitPrice FROM Product as P WHERE P.Description = '" + Description + "'";
                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);
                SQLConn.dr = SQLConn.cmd.ExecuteReader();

                if (SQLConn.dr.Read())
                {

                    DRecords.Add(new ProdRecords()
                    {
                        Barcode = SQLConn.dr["Barcode"].ToString(),
                        ProductCode = SQLConn.dr["ProductCode"].ToString(),
                        Description = SQLConn.dr["Description"].ToString(),
                        UnitPrice = SQLConn.dr["UnitPrice"].ToString()
                    });
                   

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
            return DRecords;
        }


        public static List<ProdRecords> LoadFromBARCODE(string Barcode)
        {
            List<ProdRecords> DRecords = new List<ProdRecords>();
            try
            {
                SQLConn.sqL = "SELECT ProductCode, Description, UnitPrice, StocksOnHand FROM Product as P WHERE P.Barcode = '" + Barcode + "' ORDER BY P.Description";
                SQLConn.ConnDB();
                SQLConn.cmd = new MySqlCommand(SQLConn.sqL, SQLConn.conn);
                SQLConn.dr = SQLConn.cmd.ExecuteReader();

                while (SQLConn.dr.Read() == true)
                {
                    DRecords.Add(new ProdRecords()
                    {
                        ProductCode = SQLConn.dr["ProductCode"].ToString(),
                        Description = SQLConn.dr["Description"].ToString(),
                        UnitPrice = SQLConn.dr["UnitPrice"].ToString()
                    });

                    /*textBox2.Text = SQLConn.dr["ProductCode"].ToString();
                    comboBox2.Text = SQLConn.dr["Description"].ToString();
                    textBox4.Text = SQLConn.dr["UnitPrice"].ToString();*/
                }
                //textBox5.Text = "1";

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
            return DRecords;
        }


    } // END class POS_DBQueries 
}// END namespace
