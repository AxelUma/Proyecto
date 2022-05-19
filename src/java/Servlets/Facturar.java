/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entidades.DetalleFactura;
import Entidades.Factura;
import LogicaNegocio.BL_Factura;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author gollo163
 */
public class Facturar extends HttpServlet {
     
     protected void processRequest(HttpServletRequest request, HttpServletResponse response)
             throws ServletException, IOException {
          response.setContentType("text/html;charset=UTF-8");
          PrintWriter out = response.getWriter();
          try {
               BL_Factura logicaF = new BL_Factura();
               Factura Entidad_F = new Factura();
               DetalleFactura Entidad_D = new DetalleFactura();
               int resultado;
               String mensaje = "";
               //crear entidad de factura
               if (request.getParameter("txtNombreCliente") != null && !request.getParameter("txtNombreCliente").equals("") &&
                       request.getParameter("txtNombreEmpleado") != null && !request.getParameter("txtNombreEmpleado").equals("")){
                    
                    Entidad_F.setIdCliente(Integer.parseInt(request.getParameter("txtIdCliente")));
                    Entidad_F.setIdFactura(Integer.parseInt(request.getParameter("txtnumFactura")));
                    SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
                    String fechaString = request.getParameter("txtFechaFactura");
                    
                    Date fecha = formato.parse(fechaString);
                    java.sql.Date fechasql = new java.sql.Date(fecha.getTime());
                    
                    Entidad_F.setFecha(fechasql);
                    Entidad_F.setIdVendedor(Integer.parseInt(request.getParameter("txtIdEmpleado")));
                    Entidad_F.setEstado("Pendiente");
                    
                    if (   !(request.getParameter("txtdescripcion").equals("")) &&
                            !(request.getParameter("txtcantidad").equals("")) &&
                            !(request.getParameter("txtprecio").equals(""))){
                         //crear entidad de detalle
                         Entidad_D.setIdFactura(-1);
                         Entidad_D.setIdProducto(Integer.parseInt(request.getParameter("txtIdProducto")));
                         Entidad_D.setCantidad(Integer.parseInt(request.getParameter("txtcantidad")));
                         Entidad_D.setPrecio(Double.parseDouble(request.getParameter("txtprecio")));
                         
                         resultado = logicaF.Insertar(Entidad_F, Entidad_D);
                         mensaje = logicaF.getMensaje();
                    } else {
                         resultado = logicaF.ModificarCliente(Entidad_F);
                    }
                    response.sendRedirect("Frm_Facturar.jsp?msgfac=" + mensaje + "&txtnumFactura=" + resultado);
               } else {
                    response.sendRedirect("Frm_Facturar.jsp?txtnumFactura=" + request.getParameter("txtnumFactura"));
               }
          }
          catch (Exception ex){
               out.print(ex.getMessage());
          }
     }

     // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
     /**
      * Handles the HTTP <code>GET</code> method.
      *
      * @param request servlet request
      * @param response servlet response
      * @throws ServletException if a servlet-specific error occurs
      * @throws IOException if an I/O error occurs
      */
     @Override
     protected void doGet(HttpServletRequest request, HttpServletResponse response)
             throws ServletException, IOException {
          processRequest(request, response);
     }

     /**
      * Handles the HTTP <code>POST</code> method.
      *
      * @param request servlet request
      * @param response servlet response
      * @throws ServletException if a servlet-specific error occurs
      * @throws IOException if an I/O error occurs
      */
     @Override
     protected void doPost(HttpServletRequest request, HttpServletResponse response)
             throws ServletException, IOException {
          processRequest(request, response);
     }

     /**
      * Returns a short description of the servlet.
      *
      * @return a String containing servlet description
      */
     @Override
     public String getServletInfo() {
          return "Short description";
     }// </editor-fold>

}
