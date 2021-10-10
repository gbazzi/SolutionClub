﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using System.Data;
using System.Data.SqlClient;

namespace Repositorios
{
    public class RepoHorarios : IRepositorio<Horario>
    {
        public bool Alta(Horario obj) //FALTA EL ID DE ACTIVIDAD
        {
            if (obj == null || !obj.ValidarHora(obj.Hora))
                return false;
            Conexion manejadorConexion = new Conexion();
            SqlConnection con = manejadorConexion.CrearConexion();

            try
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    int idActividad = 1;//new Actividad().Id;
                    //VER COMO PASAMOS EL ID DE LA ACTIVIDAD
                    cmd.Connection = con;
                    cmd.CommandText = "Alta_Horario";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@idActividad", idActividad));
                    cmd.Parameters.Add(new SqlParameter("@hora", obj.Hora));
                    cmd.Parameters.Add(new SqlParameter("@dia", obj.Dia));
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                return true;
            }
            catch (SqlException Ex)
            {
                return false;
            }
            finally
            {
                con.Close();
            }
        }

        public bool Baja(int id) //NO SE IMPLEMENTA
        {
            throw new NotImplementedException();
        }

        public Horario BuscarPorId(int id)
        {
            throw new NotImplementedException();
        }

        public bool Modificacion(Horario obj) //NO SE IMPLEMENTA
        {
            throw new NotImplementedException();
        }

        public List<Horario> TraerTodos()
        {
            Conexion manejadorConexion = new Conexion();
            SqlConnection con = manejadorConexion.CrearConexion();
            try
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandText = "Listar_Horarios";
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    List<Horario> listaHorarios = new List<Horario>();
                    SqlDataReader filas = cmd.ExecuteReader();
                    while (filas.Read())
                    {
                        Horario hor = new Horario
                        {
                            Id = (int)filas["idActividad"],
                            Dia = (int)filas["dia"],
                            Hora = (int)filas["hora"]
                        };
                        listaHorarios.Add(hor);
                    }
                    return listaHorarios;
                }
            }
            catch (SqlException Ex)
            {
                return null;
            }
            finally
            {
                con.Close();
            }
        }

    }
}
