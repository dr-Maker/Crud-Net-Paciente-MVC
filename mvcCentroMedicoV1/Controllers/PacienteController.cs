using Buss;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Controllers
{
    public class PacienteController : Controller
    {
        // GET: Paciente
        public ActionResult Index()
        {
            List<PacienteModel> lista = BussPaciente.Listar();
            return View(lista);
        }

        [HttpGet]
        public ActionResult Nuevo()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Nuevo(FormCollection frm)
        {
            PacienteModel obj = new PacienteModel();
            //obj.idpaciente = int.Parse(frm["idpaciente"]);
            obj.nombres = frm["nombres"];
            obj.apellidos = frm["apellidos"];
            obj.email = frm["email"];
            obj.telefono = int.Parse(frm["telefono"]);
            obj.genero = Char.Parse(frm["genero"]);
            obj.edad = int.Parse(frm["edad"]);

            BussPaciente.Insert(obj);

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult Modificar(int id)
        {
            PacienteModel obj = BussPaciente.Buscar(id);
            return View(obj);
        }


        [HttpPost]
        public ActionResult Modificar(int id, FormCollection frm)
        {
            PacienteModel obj = new PacienteModel();
            obj.idpaciente = id;
            obj.nombres = frm["nombres"];
            obj.apellidos = frm["apellidos"];
            obj.email = frm["email"];
            obj.telefono = int.Parse(frm["telefono"]);
            obj.genero = Char.Parse(frm["genero"]);
            obj.edad = int.Parse(frm["edad"]);

            BussPaciente.Update(obj);

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult Borrar(int id)
        {
            PacienteModel obj = BussPaciente.Buscar(id);
            return View(obj);
        }


        [HttpPost]
        public ActionResult Borrar(int id, FormCollection frm)
        {
            BussPaciente.Delete(id);

            return RedirectToAction("Index");
        }
    }
}