using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace Data
{
    public class BaseDatos
    {
        string conx = ConfigurationManager.AppSettings["conx1"];

        public DataTable ejecutarConsulta(SqlCommand cmd)
        {
            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            try
            {
                cmd.Connection = new SqlConnection(conx);
                sda.Fill(dt);
            }catch(SqlException exe)
            {
                dt = null;
            }
            return dt;
        }

        public bool ejecutarAccion(SqlCommand cmd)
        {
            bool std = true;
            try
            {
                cmd.Connection = new SqlConnection(conx);
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
            catch (SqlException exe)
            {
                std = false;
            }
            return std;
        }
    }
}