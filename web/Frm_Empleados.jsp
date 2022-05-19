<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidades.Empleado" %>
<%@page import="LogicaNegocio.BL_Empleado" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Agregar Empleados</title>
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
        
        <div class="container">
            <div class="row">
                <div class="col-md-8 mx-auto">
                    <div class="card-header">
                        <h1>Lista de Productos</h1>
                    </div>

                    <%
                        Empleado entidad;
                        BL_Empleado logica = new BL_Empleado();
                        int id;
                        if (request.getParameter("txtIdempleado") != null
                                && !request.getParameter("txtIdempleado").equals("")) {
                            id = Integer.parseInt(request.getParameter("txtIdempleado"));
                            entidad = logica.ObtenerRegistro("id =" + id);
                        } else {
                            entidad = new Empleado();
                            entidad.setId(-1);
                        }
                    %>
                    <br>
                    <form action="AddEmpleado" method="post">

                        <div class="form-group">
                            <input type="hidden" name="txtIdempleado" id="txtIdempleado" class="form-control"
                                   value="<%= entidad.getId()%>" readonly/>

                            <label for="txtCedula">Cédula</label>
                            <input type="text" name="txtCedula" id="txtCedula" 
                                   value="<%= entidad.getCedula()%>" required class="form-control"/>
                        </div>  
                        <div class="form-group">
                            <label for="txtCodigo">Código</label>
                            <input type="text" name="txtCodigo" id="txtCodigo" 
                                   value="<%= entidad.getCodigo()%>" required class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label for="txtNombre">Nombre</label>
                            <input type="text" name="txtNombre" id="txtNombre" 
                                   value="<%= entidad.getNombre()%>" required class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label for="txtTelefono">Teléfono</label>
                            <input type="text" name="txtTelefono" id="txtTelefono" 
                                   value="<%= entidad.getTelefono()%>" required class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label for="txtCorreo">Correo</label>
                            <input type="text" name="txtCorreo" id="txtCorreo" 
                                   value="<%= entidad.getCorreo()%>" required class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label for="txtPuesto">Puesto</label>
                            <input type="text" name="txtPuesto" id="txtPuesto" 
                                   value="<%= entidad.getPuesto()%>" required class="form-control"/>
                        </div>  
                        <div class="form-group">
                            <label for="txtSalario">Salario</label>
                            <input type="text" name="txtSalario" id="txtSalario" 
                                   value="<%= entidad.getSalario()%>" required class="form-control"/>
                        </div>  
                        <div class="form-group">
                            <input type="submit" value="Guardar" class="btn btn-primary">
                            <input type="button" id="btnRegresar" value="Regresar" onclick="location.href = 'Frm_ListarEmpleados.jsp'" class="btn btn-secondary"/>
                        </div>  
                    </form>
                </div> <!-- clase que crea las 6 columnas -->

            </div> <!-- class row, div de la fila -->

        </div> <!-- class container -->

        <script src="lib/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>
