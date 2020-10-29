using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Models
{
    public class PacienteModel
    {

        public int idpaciente { get; set; }

        public string nombres { get; set; }

        public string apellidos { get; set; }

        public string email { get; set; }

        public int telefono { get; set; }

        public char genero { get; set; }

        public int edad { get; set; }

        public PacienteModel()
        {
            nombres = string.Empty;
            apellidos = string.Empty;
            email = string.Empty;
            
        }

        public string NomPaciente
        {
            get
            {
                return nombres + " " + apellidos;
            }
        }
    }
}