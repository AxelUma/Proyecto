<%@page import="Entidades.Empleado"%>
<%@page import="Entidades.Factura"%>
<%@page import="LogicaNegocio.*"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DateFormat"%>
<!--Creado para hacer pdf-->
<%@page import="com.itextpdf.text.Document"%>
<%@page import="com.itextpdf.text.DocumentException"%>
<%@page import="com.itextpdf.text.pdf.PdfPTable"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="lib/bootstrap-datepicker/css/bootstrap-datepicker3.standalone.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/fontawesome-free-5.14.0-web/css/all.min.css" rel="stylesheet" type="text/css"/>
        <title>Listado de Facturas</title>
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
            <div class="card-header">
                <h1>Listado de Facturas Pendientes</h1>
            </div>
            <br/>

            <form action="FrmListarFacturas.jsp" method="post">
                 <!-- Este datepicker funciona para buscar por mes solamente -->
                <div class="form-group">
                    <div class="input-group">
                        <input type="text" id="txtfechaMes" name="txtfechaMes" value="" placeholder="Seleccione la fecha" class="datepicker"/>&nbsp; &nbsp;
                        <input type="submit" id="btnbuscarMes" name="btnbuscarMes" value="Buscar por Mes" class="btn-success"/><br><br>
                    </div>
                </div>
                 <div class="form-group">
                    <div class="input-group">
                        <input type="text" id="txtfechaInicio" name="txtfechaInicio" value="" placeholder="Seleccione la fecha Inicial" class="datepicker"/>&nbsp; &nbsp;
                        <input type="text" id="txtfechaFinal" name="txtfechaFinal" value="" placeholder="Seleccione la fecha final" class="datepicker"/>&nbsp; &nbsp;
                        <input type="submit" id="btnbuscar" name="btnBuscar" value="Buscar por Rango" class="btn-success"/><br><br>
                    </div>
                </div>
                 <!-- Espacio para llamar al empleado a buscar-->
                  <div class="form-group">
                      <div class="input-group">
                           <input type="hidden" id="txtIdEmpleado" name="txtIdEmpleado" value =""readonly="" class="form-control"/>
                           <input type="text" id="txtNombreEmpleado" name="txtNombreEmpleado" value ="" readonly="" class="form-control" placeholder="Seleccione un Empleado"/>&nbsp; &nbsp;
                           <a id="btnbuscar" class="btn btn-success" data-toggle="modal" data-target="#buscarEmpleado"><i class="fas fa-search"></i></a>
                      </div>
                 </div>
            </form>
            <hr/>
           
            <table class="table">
                <thead>
                    <tr id="titulos">
                        <th>Num. Factura</th>
                        <th>Vendedor</th>
                        <th>Cliente</th>
                        <th>Fecha</th>
                        <th>Estado</th>
                        <th>Opciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String fecha = "";
                        String condicion = "";
                        if (request.getParameter("txtfechaMes")!=null && !request.getParameter("txtfechaMes").equals("")){ 
                            fecha = request.getParameter ("txtfechaMes");
                            condicion= condicion + "MONTH(FECHA) = MONTH('" + fecha + "')"; //solo toma el  mes de la fecha seleccionada y busca cual de las facturas fueron hechas en ese mes
                            //En caso de que se quiera buscar por rango, el de mes ha de estar vacio
                        } else if (request.getParameter("txtfechaInicio")!=null && !request.getParameter("txtfechaInicio").equals("") 
                        && request.getParameter("txtfechaFinal")!=null && !request.getParameter("txtfechaFinal").equals("") 
                        && request.getParameter("txtNombreEmpleado")!=null && !request.getParameter("txtNombreEmpleado").equals("")){ 
                            String fecha1 = request.getParameter ("txtfechaInicio");
                            String fecha2 = request.getParameter ("txtfechaFinal");
                            int id = Integer.parseInt(request.getParameter("txtIdEmpleado"));
                            condicion= condicion + "FECHA BETWEEN '" + fecha1 + "' AND '" + fecha2 +"' AND ID_VENDEDOR = " + id;
                        }
                        BL_Factura logica = new BL_Factura();
                        List<Factura> datos;
                        datos=logica.ListarRegistros(condicion);
                        for (Factura registro:datos){ 
                    %>

                    <tr>
                        <%int num=registro.getIdFactura();%>
                        
                        <td><%= num%></td>
                        <td><%= registro.getNombreEmpleado()%></td>
                        <td><%= registro.getNombreCliente()%></td>
                        <td><%= registro.getFecha()%></td>
                        <td><%= registro.getEstado()%></td>
                        
                        <!-- Columna adicional con botones de opciones: -->
                        <td>
                            <a href="Frm_Facturar.jsp?txtnumFactura=<%=num%>"><i class="fas fa-user-edit"></i></a> |
                        </td>
                    </tr>
                    
                    <%}%> <!--Cerrar la llave del FOR de JAVA
                                La llave se cierra donde se termina la fila, la table row tr-->
                </tbody>
            </table>
            <br>
            <a href="Frm_Facturar.jsp?txtnumFactura=-1" class="btn btn-primary">Nueva Factura</a> 
            <div class="float-right">
                 <!-- <a class="btn btn-secondary" onclick="CrearPDF()">Crear PDF para Facturas</a>-->
            </div>
        </div>
        
        <!-- Modal de Empleados -->
        <div class="modal" id="buscarEmpleado" tabindex="1" role="dialog" aria-labelledby="tituloVentana">
             <div class="modal-dialog" role="document">
                  <div class="modal-content">
                       <div class="modal-header">
                            <h5 id="tituloVentaja">Buscar Empleado</h5>
                            <button class="close" data-dismiss="modal" aria-label="Cerrar" aria-hidden="true" onclick="Limpiar()">
                                 <span aria-hidden="true">&times;</span>
                            </button>
                       </div>
                       <div class="modal-body">
                            <table id="tablaEmpleados">
                                 <thead>
                                      <tr>
                                           <th>Código</th>
                                           <th>Nombre</th>
                                           <th>Seleccionar</th>
                                      </tr>
                                 </thead>
                                 <tbody>
                                      <%
                                           BL_Empleado logicaEmpleado = new BL_Empleado();
                                           List<Empleado> datosE;
                                           datosE = logicaEmpleado.ListarRegistros("");
                                           for (Empleado registroE : datosE)  {
                                      %>
                                      <tr>
                                           <% int codigoEmpleado = registroE.getId();
                                                  String nombreEmpleado = registroE.getNombre();%>
                                           <td><%= codigoEmpleado%></td>
                                           <td><%= nombreEmpleado%></td>
                                           <td>
                                                <a href="#" data-dismiss="modal"
                                                   onclick="SeleccionarEmpleado('<%=codigoEmpleado%>', '<%= nombreEmpleado%>');">Seleccionar</a>
                                           </td>
                                      </tr>
                                      <%}%>
                                 </tbody>
                            </table>
                       </div> <!-- Modal Body-->
                       <div class="modal-footer">
                            <button class="btn btn-warning" type="button" data-dismiss="modal" onclick="LimpiarEmpleado()">
                                 Cancelar
                            </button>
                       </div>
                  </div> <!-- Modal Content-->
             </div> <!-- Modal Dialog-->
        </div> <!-- Modal -->
                                
        <script src="lib/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap-datepicker/locales/bootstrap-datepicker.es.min.js" type="text/javascript"></script>
        <script>
             $(document).ready(function () {
                    $('.datepicker').datepicker({
                        format: 'yyyy-mm-dd',
                        autoclose: true,
                        lenguage: 'es'
                    });
                    $('#tablaEmpleados').dataTable({
                        "lenghtMenu": [[5, 15, 15, -1], [5, 10, 15, "All"]],
                        "language": {
                            "info": "Pagina _PAGE_ de _PAGES_",
                            "infoEmpty": "No existen Registros disponibles",
                            "zeroRecords": "No se encuentran registros",
                            "search": "Buscar",
                            "infoFiltered": "",
                            "lenghtMenu": "Mostrar _MENU_ Registro",
                            "paginate": {
                                "first": "Primero",
                                "last": "Ultimo",
                                "next": "Siguiente",
                                "previous": "Anterior"
                            }
                        }
                    });
               });
               function SeleccionarEmpleado(idEmpleado, nombreEmpleado){
                  $("#txtIdEmpleado").val(idEmpleado);
                  $("#txtNombreEmpleado").val(nombreEmpleado);
             }
               function CrearPDF(){
                    Document documento = new Document();
                    
                    try {
                         //acceso de ruta esta el acceso a la carpeta de usuario donde se ejecuta el programa
                         String ruta = System.getProperty("user.home");
                         PdfWriter.getInstance(document, new FileOutputStream(ruta + "/Desktop/Lista_Facturas.pdf")); //Direccion donde se creara
                         documento.open();
                         //se crea dentro de document
                         PdfTable tabla = new PdfTable(5);
                         tabla.addCell("Num_Factura");
                         tabla.addCell("Vendedor");
                         tabla.addCell("Cliente");
                         tabla.addCell("Fecha");
                         tabla.addCell("Estado");
                         
                         try {
                              Connection cn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=Proyecto_final;user=sa;password=sa;");
                              PreparedStatement pst = cn.prepareStatement("select Numero_factura,id_vendedor,id_cliente,fecha,estado from ");
                              
                              ResultSet rs = pst.executeQuery();
                              if(rs.next()){
                                   do {
                                        tabla.addCell(rs.getString(1));
                                        tabla.addCell(rs.getString(2));
                                        tabla.addCell(rs.getString(3));
                                        tabla.addCell(rs.getString(4));
                                        tabla.addCell(rs.getString(5));
                                   } while (rs.next());
                                   documento.add(tabla);
                              }
                              
                         } catch (DocumentException | SQLException e){
                              
                         }
                         documento.close();
                    } catch(DocumentException | HeadlessException | FileNotFoundException e){
                         
                    }
               }
        </script>
    </body>
</html>





















