using Data;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Buss
{
    public class BussPaciente
    {
        static BaseDatos db = new BaseDatos();

        public static List<PacienteModel> Listar()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sp_listar_paciente";
            DataTable dt = db.ejecutarConsulta(cmd);
            List<PacienteModel> lista = new List<PacienteModel>();
            PacienteModel obj;
            foreach (DataRow row in dt.Rows)
            {
                obj = new PacienteModel();
                obj.idpaciente = int.Parse(row["idpaciente"].ToString());
                obj.nombres = row["nombres"].ToString();
                obj.apellidos = row["apellidos"].ToString();
                obj.email = row["email"].ToString();
                obj.telefono = int.Parse(row["telefono"].ToString());
                obj.genero = char.Parse(row["genero"].ToString());
                obj.edad = int.Parse(row["edad"].ToString());

                lista.Add(obj);
            }

            return lista;
        }

        public static PacienteModel Buscar(int id)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sp_buscar_paciente";
            cmd.Parameters.Add("@idpaciente", SqlDbType.Int).Value = id;
            DataTable dt = db.ejecutarConsulta(cmd);

            PacienteModel obj = new PacienteModel();
            foreach (DataRow row in dt.Rows)
            {
               
                obj.idpaciente = int.Parse(row["idpaciente"].ToString());
                obj.nombres = row["nombres"].ToString();
                obj.apellidos = row["apellidos"].ToString();
                obj.email = row["email"].ToString();
                obj.telefono = int.Parse(row["telefono"].ToString());
                obj.genero = char.Parse(row["genero"].ToString());
                obj.edad = int.Parse(row["edad"].ToString());
                
            }

            return obj;
        }

        public static bool Insert(PacienteModel obj)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sp_insert_paciente";
            cmd.Parameters.Add("@nombres", SqlDbType.VarChar, 50).Value = obj.nombres;
            cmd.Parameters.Add("@apellidos", SqlDbType.VarChar, 50).Value = obj.apellidos;
            cmd.Parameters.Add("@telefono", SqlDbType.Int).Value = obj.telefono;
            cmd.Parameters.Add("@email", SqlDbType.VarChar, 50).Value = obj.email;
            cmd.Parameters.Add("@genero", SqlDbType.VarChar, 50).Value = obj.genero;
            cmd.Parameters.Add("@edad", SqlDbType.VarChar, 50).Value = obj.edad;

            return db.ejecutarAccion(cmd);
        }

        public static bool Update(PacienteModel obj)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sp_update_paciente";
            cmd.Parameters.Add("@idpaciente", SqlDbType.VarChar, 50).Value = obj.idpaciente;
            cmd.Parameters.Add("@nombres", SqlDbType.VarChar, 50).Value = obj.nombres;
            cmd.Parameters.Add("@apellidos", SqlDbType.VarChar, 50).Value = obj.apellidos;
            cmd.Parameters.Add("@telefono", SqlDbType.Int).Value = obj.telefono;
            cmd.Parameters.Add("@email", SqlDbType.VarChar, 50).Value = obj.email;
            cmd.Parameters.Add("@genero", SqlDbType.VarChar, 50).Value = obj.genero;
            cmd.Parameters.Add("@edad", SqlDbType.VarChar, 50).Value = obj.edad;

            return db.ejecutarAccion(cmd);
        }

        public static bool Delete(int id)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sp_delete_paciente";
            cmd.Parameters.Add("@idpaciente", SqlDbType.Int).Value = id;

            return db.ejecutarAccion(cmd);
        }
    }
}