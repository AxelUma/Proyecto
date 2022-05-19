<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<!-- -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidades.Empleado"%>
<%@page import="LogicaNegocio.BL_Empleado"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Lista de Empleados</title>
        <link href="lib/bootstrap-datepicker/css/bootstrap-datepicker3.standalone.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/fontawesome-free-5.14.0-web/css/all.min.css" rel="stylesheet" type="text/css"/>

    </head>
    <body>
         <header>
        <nav class="navbar navbar-expand-sm navbar-toggleable-sm navbar-light bg-white border-bottom box-shadow mb-3">
            <div class="container">
                <a class="navbar-brand" href="index.html">Sistema Facturación <i class="fas fa-tasks"></i></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".navbar-collapse" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="navbar-collapse collapse d-sm-inline-flex flex-sm-row-reverse">
                    <ul class="navbar-nav flex-grow-1">
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="index.html">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="Frm_ListarProductos.jsp">Productos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="Frm_ListarServicios.jsp">Servicios</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="FrmListarClientes.jsp">Clientes</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="FrmListarClientes.jsp">Vehículos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="Frm_ListarEmpleados.jsp">Empleados</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="Frm_ListarOrdenes.jsp">Ordenes</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="FrmListarFacturas.jsp">Facturación</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

        <div class="container">  <!-- container y card-header son clases de BOOTSTRAP -->
            <div class="row">
                <div class="col-md-12 mx-auto">

                    <div class="card-header">
                        <h1>Listado de Empleados</h1>
                    </div>
                    <br/>

                    <form action="Frm_ListarEmpleados.jsp" method="post">
                        <div class="form-group">
                            <div class="input-group">
                                <label for="txtnombre">Nombre del Empleado</label>&nbsp; &nbsp;
                                <!-- el for de este label lo unico que hace asociar esa etiqueta con el input -->
                                <input type="text" id="txtnombre" name="txtnombre" value="" placeholder="Empleado" class="form-control"/>&nbsp; &nbsp;
                                <input type="submit" value="Buscar" name="btnBuscar" class="btn btn-primary"/>
                            </div>
                        </div>
                    </form>
                    <br>

                    <%
                        if (request.getParameter("mensaje") != null
                                && !request.getParameter("mensaje").equals("")) {
                            out.print("<p style='color:red'>" + request.getParameter("mensaje") + "</p>");
                        }
                    %>

                    <table class="table">
                        <tr>
                            <th style="text-align: left">ID</th>
                            <th style="text-align: left">Cédula</th>
                            <th style="text-align: left">Nombre</th>
                            <th style="text-align: left">Puesto</th>
                            <th style="text-align: left">Teléfono</th>
                            <th style="text-align: left">Correo</th>
                            <th style="text-align: left">Opciones</th>
                        </tr>

                        <%
                              String nombre; // la vamos a llenar con lo que traiga la solicitud
                            String condicion = "borrado = 0";
                            if (request.getParameter("txtnombre") != null
                                    && !request.getParameter("txtnombre").equals("")) {
                                nombre = request.getParameter("txtnombre");
                                condicion += " and nombre_e like '%" + nombre + "%'";
                            }
                            BL_Empleado logica = new BL_Empleado();
                            List<Empleado> datos = logica.ListarRegistros(condicion);
                            for (Empleado registro : datos) {
                        %>

                        <tr>
                            <td><%=registro.getId()%></td>
                            <td><%= new String(registro.getCedula().getBytes("ISO-8859-1"), "UTF-8")%></td>
                            <td><%= new String(registro.getNombre().getBytes("ISO-8859-1"), "UTF-8")%></td>
                            <td><%= new String(registro.getCodigo().getBytes("ISO-8859-1"), "UTF-8") + " " + new String(registro.getPuesto().getBytes("ISO-8859-1"), "UTF-8")%></td>
                            <td><%= new String(registro.getTelefono().getBytes("ISO-8859-1"), "UTF-8")%></td>
                            <td><%= new String(registro.getCorreo().getBytes("ISO-8859-1"), "UTF-8")%></td>
                            <td>
                                <a href="Frm_Empleados.jsp?txtIdempleado=<%=registro.getId()%>"><i class="fas fa-user-edit"></i></a> |
                                <a href="EliminarEmpleado?txtIdempleado=<%=registro.getId()%>"><i class="fas fa-trash-alt"></i></a>
                            </td>
                        </tr>
                        <% } // fin del For %>

                    </table>

                    <br>
                    <a href="Frm_Empleados.jsp" class="btn btn-primary" >Agregar Nuevo Empleado</a>
                    <a href="Frm_ListarEmpleados.jsp" class="btn btn-primary">Actualizar</a>

                </div> <!-- clase que crea las 6 columnas -->

            </div> <!-- class row, div de la fila -->

        </div> <!-- class container -->

        <script src="lib/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>

    </body>
</html>

