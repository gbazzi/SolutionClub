﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Dominio;
using Repositorios;
using WCF_AltaSocioActividad;

namespace MVC_Club.Controllers
{
    public class FuncionarioController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult RegistroSocio()
        {
            ViewBag.socioCreado = false;
            return View();
        }
        [HttpPost]
        public ActionResult RegistroSocio(int cedula, string nombre, DateTime fechaNac)
        {
            bool socioCreado = FachadaClub.AltaSocio(cedula, nombre, fechaNac);
            ViewBag.mensaje = (socioCreado) ? "Socio registrado con éxito." : "No se pudo registrar el socio.";
            ViewBag.socioCreado = socioCreado;
            return View();
        }
        public ActionResult Buscar()
        {
            if (Session["Logueado"] == null)
            {
                return Redirect("/Inicio/Login");
            }
            return View();
        }
        public ActionResult Listar()
        {
            if (Session["Logueado"] == null)
            {
                return Redirect("/Inicio/Login");
            }
            List<Socio> listadoSocios = FachadaClub.ListarSocios();
            ViewBag.listadoSocios = listadoSocios;
            return View();
        }
        public ActionResult DetalleSocio(int cedula = 0)
        {
            ViewBag.mensajeDatosActualizados = "";
            ViewBag.SocioModificado = false;
            if(cedula == 0)
            {
                ViewBag.mensaje = "Ingresa una cédula válida para ver el detalle.";
                return View("Buscar");
            }
            ViewBag.mensaje = "";
            if (Session["Logueado"] == null)
            {
                return Redirect("/Inicio/Login");
            }
            Socio socio = FachadaClub.BuscarPorId(cedula);
            if(socio == null)
            {
                ViewBag.mensaje = "No se encontró socio con la cédula ingresada.";
                return View("Buscar");
            }
            ViewBag.socio = socio;
            ViewBag.mensualidadPaga = FachadaClub.VerificarMensualidad(socio);
            return View();
        }
        [HttpPost]
        public ActionResult DetalleSocio(int cedula, string nombre, DateTime fechaNac)
        {
            ViewBag.mensualidadPaga = false;
            ViewBag.mensajeDatosActualizados = "";
            bool socioModificado = FachadaClub.ModificarSocio(cedula, nombre, fechaNac);
            ViewBag.mensajeDatosActualizados = (socioModificado) ? "Se modificaron los datos con éxito." : "No se pudo actualizar datos.";
            ViewBag.socioModificado = socioModificado;
            Socio socio = FachadaClub.BuscarPorId(cedula);
            ViewBag.socio = socio;
         
            return View();
        }
        public ActionResult PagarMensualidad(int cedula = 0)
        {
            if (Session["Logueado"] == null)
            {
                return Redirect("/Inicio/Login");
            }
            Socio socio = FachadaClub.BuscarPorId(cedula);
            ViewBag.socio = socio;
            return View();
        }
        [HttpPost]
        public ActionResult PagarMensualidad(int cedula, int membresia, int cantActividades = 0)
        {
            //ESTO NO ESTA ANDANDO - NO ENTRA NUNCA
            Socio socio = FachadaClub.BuscarPorId(cedula);
            ViewBag.mensualidadPaga = FachadaClub.VerificarMensualidad(socio);
            if (membresia == 1 && !ViewBag.mensualidadPaga)
            {
                ViewBag.mensualidadPaga = FachadaClub.RegistrarPagoPaseLibre(cedula);
            } else if(membresia == 2 && !ViewBag.mensualidadPaga)
            {
                ViewBag.mensualidadPaga = FachadaClub.RegistrarPagoCuponera(cedula, cantActividades);
            }
            ViewBag.socio = socio;
            return View("");
        }
        public ActionResult MostrarCostoMensualidad(int cedula)
        {
            if (Session["Logueado"] == null)
            {
                return Redirect("/Inicio/Login");
            }
            Socio socio = FachadaClub.BuscarPorId(cedula);
            ViewBag.socio = socio;

            return View("PagarMensualidad");
        }
        [HttpPost]
        public ActionResult MostrarCostoMensualidad(int cedula, string nombre, DateTime fechaNac, DateTime fechaIngreso, int selectMembresia, int cantActividades = 0)
        {
            double costoCuota;
            if (selectMembresia == 1)
            {
                costoCuota = FachadaClub.MostrarCostoPaseLibre(cedula);
                ViewBag.slectedOption = 1;
                ViewBag.showCuponera = "none";
            }
            else
            {
                costoCuota = FachadaClub.MostrarCostoCuponera(cedula, cantActividades);
                ViewBag.slectedOption = 2;
                ViewBag.showCuponera = "block";
                ViewBag.cantActividades = cantActividades;
            }
            ViewBag.costoCuota = costoCuota;
            Socio socio = FachadaClub.BuscarPorId(cedula);
            ViewBag.socio = socio;
            return View("PagarMensualidad");
        }
        public ActionResult DarDeBaja(int cedula = 0)
        {
            bool dadoDeBaja = FachadaClub.DarDeBajaSocio(cedula);
            ViewBag.mensajeDatosActualizados = (dadoDeBaja) ? "El socio fue dado de baja." : "";
            Socio socio = FachadaClub.BuscarPorId(cedula);
            ViewBag.socio = socio;
            return View("DetalleSocio");
        }
        public ActionResult Logout()
        {
            Session["Logueado"] = null;
            return Redirect("/Inicio/Login");
        }
        public ActionResult ListarActividades()
        {
            if (Session["Logueado"] == null)
            {
                return Redirect("/Inicio/Login");
            }
            ServicioAltaSocioActividad servicioActividad = new ServicioAltaSocioActividad();
            //servicioActividad.Open(); ESTO PARA QUE ERA? NO SIRVE
            //TRAER LOS HORARIOS DE CADA ACTIVIDAD
            //ASOCIAR ACTIVIDAD AL SOCIO
            IEnumerable<DtoActividad> listaActividades = servicioActividad.ListarActividades();
            ViewBag.ListaActividades = listaActividades;
            return View();
        }
    }
}