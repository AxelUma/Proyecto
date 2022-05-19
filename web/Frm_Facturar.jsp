<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="LogicaNegocio.*"%>
<%@page import="Entidades.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <!-- Agregamos los vínculos a Bootstrap y a nuestro archivo de estilos: -->
        <link href="lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/boostrap-datapicker/css/boostrap-datapicker3.standalone.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/fontawesome-free-5.14.0-web/css/all.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/DataTables/datatables.min.css" rel="stylesheet" type="text/css"/>
        <title>Facturacion</title>
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
                <div class="col-10"><h1>Facturación</h1></div>
                
            </div>
            <%
                 int numFactura = -1;
                 double Subtotal = 0;
                 Factura entidad_F;
                 BL_Factura logica_F = new BL_Factura();
                 BL_Detalle logica_D = new BL_Detalle();
                 List<DetalleFactura> DatosDetalle = null;
                 if (request.getParameter("txtnumFactura") != null && Integer.parseInt(request.getParameter("txtnumFactura")) != -1) {
                         numFactura = Integer.parseInt(request.getParameter("txtnumFactura"));
                         entidad_F = logica_F.ObtenerRegistro("Numero_factura = " + numFactura);
                         DatosDetalle = logica_D.ListarRegistros("Id_Factura = " + numFactura);
                 } else {
                         entidad_F = new Factura();
                         entidad_F.setIdFactura(-1);
                         Date fecha = new Date();
                         java.sql.Date fechasql = new java.sql.Date(fecha.getTime());
                         entidad_F.setFecha(fechasql);
                 }
            
            %>
            <br/>
            <form action="Facturar" method="post">
                 <div class="form-group float-right">
                      <div class="input-group">
                           <label for="txtnumFactura" class="form-control">Num. Factura</label>
                           <input type="text" id="txtnumFactura" name="txtnumFactura" value="<%=entidad_F.getIdFactura()%>"
                                             readonly class="form-control"/>
                      </div>
                      
                       <div class="input-group">
                           <label for="txtFechaFactura" class="form-control">Fecha</label>
                           <input type="text" id="txtFechaFactura" name="txtFechaFactura" readonly="" value="<%=entidad_F.getFecha()%>"
                                  required class="datepicker form-control"/>
                      </div>
                 </div>     
                 <br/>
                 <div class="form-group">
                      <div class="input-group">
                           <input type="hidden" id="txtIdEmpleado" name="txtIdEmpleado" value ="<%=entidad_F.getIdVendedor()%>"
                                  readonly="" class="form-control"/>
                           <input type="text" id="txtNombreEmpleado" name="txtNombreEmpleado" 
                                  value ="<%=" Vendedor: " + entidad_F.getNombreEmpleado()%>" readonly="" class="form-control"
                                   placeholder="Seleccione un Empleado"/>&nbsp; &nbsp;
                           
                           <a id="btnbuscar" class="btn btn-success" data-toggle="modal"
                              data-target="#buscarEmpleado"><i class="fas fa-search"></i></a>
                      </div>
                 </div>
                 <hr/>
                 <div class="form-group">
                      <div class="input-group">
                           <input type="hidden" id="txtIdCliente" name="txtIdCliente" value ="<%=entidad_F.getIdCliente()%>"
                                  readonly="" class="form-control"/>
                           <input type="text" id="txtNombreCliente" name="txtNombreCliente" 
                                  value ="<%=" Cliente " + entidad_F.getNombreCliente()%>" readonly="" class="form-control"
                                   placeholder="Seleccione un Cliente"/>&nbsp; &nbsp;
                           
                           <a id="btnbuscar" class="btn btn-success" data-toggle="modal"
                              data-target="#buscarCliente"><i class="fas fa-search"></i></a>
                      </div>
                 </div>
                 <hr/>
                 <div class="form-group">
                      <div class="input-group">
                           <input type="hidden" id="txtIdProducto" name="txtIdProducto" value="" readonly="" class="form-control"/>
                           <input type="text" id="txtdescripcion" name="txtdescripcion" value="" class="form-control" readonly
                                  placeholder="Seleccione un producto"/> &nbsp; &nbsp;
                           
                           <a id="btnBuscarP" class="btn btn-success" data-toggle="modal" data-target="#buscarProducto">
                                <i class="fas fa-search"></i></a> &nbsp; &nbsp;
                                
                           <input type="number" id="txtcantidad" name="txtcantidad" value="" class="form-control"
                                  placeholder="Cantidad"/>   &nbsp; &nbsp;
                           <input type="number" id="txtprecio" readonly="true" name="txtprecio" value="" class="form-control"
                                  placeholder="Precio"/>   &nbsp; &nbsp;
                           <input type="number" id="txtexistencia" readonly name="txtexistencia" value="" class="form-control"
                                  placeholder="Existencia"/>   &nbsp; &nbsp;
                      </div>
                 </div>
                 <br/>
                 <div class="form-group">
                      <input type="submit" name="Guardar" id="btnGuardar" value="Agregar y Guardar" class="btn btn-primary"/>
                 </div>
            </form>
            <hr/>
            
                    <%
                        if (request.getParameter("mensaje") != null
                                && !request.getParameter("mensaje").equals("")) {
                            out.print("<p style='color:red'>" + request.getParameter("mensaje") + "</p>");
                        }
                    %>
            <hr/>
            <h5>Detalle de Factura</h5>
            <table id="DetalleFactura" class="table">
                 <thead>
                      <tr>
                           <th>Código</th>
                           <th>Descripción</th>
                           <th>Cantidad</th>
                           <th>Precio</th>
                           <th>SubTotal</th>
                           <th>Eliminar</th>
                      </tr>
                 </thead>
                 <tbody>
                      <% if(DatosDetalle != null) {
                               for (DetalleFactura registroDetalle : DatosDetalle) { 
                      %>
                      <tr>
                           <%
                                int numfactura = registroDetalle.getIdFactura();
                                int codigop = registroDetalle.getIdProducto();
                                String descripcion = new String(registroDetalle.getNombreProducto().getBytes("ISO-8859-1"), "UTF-8");
                                int cantidad = registroDetalle.getCantidad();
                                double precioV = registroDetalle.getPrecio();
                                Subtotal += (cantidad * precioV);
                           %>
                           <td><%=codigop%></td>
                           <td><%=descripcion%></td>
                           <td><%=cantidad%></td>
                           <td><%=precioV%></td>
                           <td><%=cantidad * precioV%></td>
                           <td>
                                <a href="EliminarDetalle?idproducto=<%=codigop%>&idfactura=<%=numfactura%>"> 
                                     <i class="fas fa-trash-alt"></i></a>
                           </td>
                      </tr>
                      <%
                               } // cierre del for
                               
                           } // cierre del if
                              double iva = Subtotal*0.13;
                              double descuento = Subtotal*0.10;
                              double total = (Subtotal + iva)-descuento;
                      %> 
                 </tbody>
            </table>
            <div class="float-right">
                 <p class="text-danger h5"> SubTotal = <%=Subtotal%></p>
                 <p class="text-danger h5">         IVA = <%=iva%></p>
                 <p class="text-danger h5">Descuento = <%=descuento%></p>
                 <p class="text-danger h5">       Total = <%=total%></p>
            </div>
            <br><br>
            <%
                 //mensaje generado en servlets facturas
                 if (request.getParameter("msgFac") != null){
                     out.print("<p class='text-danger'>" + new String(request.getParameter("msgFac").getBytes("ISO-8859-1"), "UTF-8") + "</p>");
                 }
            %>
            <input type = "button" id="btnCancelar" value = "Realizar Facturación"
                    onclick="location.href = 'CancelarFactura?txtnumFactura=' + <%=entidad_F.getIdFactura()%>"
                    class="btn btn-success"/> &nbsp; &nbsp;
            <a href="FrmListarFacturas.jsp" class="btn btn-secondary">Regresar</a>
        </div> <!-- class container -->
        
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
                                           List<Empleado> datos;
                                           datos = logicaEmpleado.ListarRegistros("");
                                           for (Empleado registroE : datos)  {
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
        
        <!-- Modal de Clientes -->
        <div class="modal" id="buscarCliente" tabindex="1" role="dialog" aria-labelledby="tituloVentana">
             <div class="modal-dialog" role="document">
                  <div class="modal-content">
                       <div class="modal-header">
                            <h5 id="tituloVentaja">Buscar Cliente</h5>
                            <button class="close" data-dismiss="modal" aria-label="Cerrar" aria-hidden="true" onclick="Limpiar()">
                                 <span aria-hidden="true">&times;</span>
                            </button>
                       </div>
                       <div class="modal-body">
                            <table id="tablaClientes">
                                 <thead>
                                      <tr>
                                           <th>Código</th>
                                           <th>Nombre</th>
                                           <th>Seleccionar</th>
                                      </tr>
                                 </thead>
                                 <tbody>
                                      <%
                                           BL_Cliente logicaCliente = new BL_Cliente();
                                           List<Cliente> datosClientes;
                                           datosClientes = logicaCliente.ListarRegistros("");
                                           for (Cliente registroC : datosClientes)  {
                                      %>
                                      <tr>
                                           <% int codigoCliente = registroC.getId();
                                                  String nombreCliente = registroC.getNombre();%>
                                           <td><%= codigoCliente%></td>
                                           <td><%= nombreCliente%></td>
                                           <td>
                                                <a href="#" data-dismiss="modal"
                                                   onclick="SeleccionarCliente('<%=codigoCliente%>', '<%= nombreCliente%>');">Seleccionar</a>
                                           </td>
                                      </tr>
                                      <%}%>
                                 </tbody>
                            </table>
                       </div> <!-- Modal Body-->
                       <div class="modal-footer">
                            <button class="btn btn-warning" type="button" data-dismiss="modal" onclick="Limpiar()">
                                 Cancelar
                            </button>
                       </div>
                  </div> <!-- Modal Content-->
             </div> <!-- Modal Dialog-->
        </div> <!-- Modal -->
        
        
        <!-- Modal de Producto -->
        <div class="modal" id="buscarProducto" tabindex="1" role="dialog" aria-labelledby="tituloVentana">
             <div class="modal-dialog" role="document">
                  <div class="modal-content">
                       <div class="modal-header">
                            <h5 id="tituloVentana">Buscar Producto</h5>
                            <button class="close" data-dismiss="modal" aria-label="Cerrar" aria-hidden="true" onclick="LimpiarProducto()">
                                 <span aria-hidden="true">&times;</span>
                            </button>
                       </div>
                       <div class="modal-body">
                            <table id="tablaProductos">
                                 <thead>
                                      <tr>
                                           <th>Código</th>
                                           <th>Descripción</th>
                                           <th>Precio</th>
                                           <th>Seleccionar</th>
                                      </tr>
                                 </thead>
                                 <tbody>
                                      <%
                                           BL_Producto logicaProducto = new BL_Producto();
                                           List<Producto> datosProductos;
                                           datosProductos = logicaProducto.ListarRegistros("");
                                           for (Producto registroP : datosProductos)  {
                                      %>
                                      <tr>
                                           <% int codigoProducto = registroP.getId();
                                                  String nombreProducto = registroP.getProducto();
                                                  double precio = registroP.getPrecioVenta();
                                                  double existencia = registroP.getCantidad();
                                           %>
                                           <td><%= codigoProducto%></td>
                                           <td><%= nombreProducto%></td>
                                           <td><%= precio%></td>
                                           <td>
                                                <a href="#" data-dismiss="modal"
                                                   onclick="SeleccionarProducto('<%=codigoProducto%>', '<%= nombreProducto%>','<%= precio%>', '<%= existencia%>');">Seleccionar</a>
                                           </td>
                                      </tr>
                                      <%}%>
                                 </tbody>
                            </table>
                       </div> <!-- Modal Body-->
                       <div class="modal-footer">
                            <button class="btn btn-warning" type="button" data-dismiss="modal" onclick="LimpiarProducto()">
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
        <script src="lib/DataTables/datatables.min.js" type="text/javascript"></script>
        <script src="lib/DataTables/DataTables-1.10.21/js/dataTables.bootstrap4.min.js" type="text/javascript"></script>
        <script>
             //cuando el documento este listo
             //carge las sigueintes funciones
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
 
                    $('#tablaClientes').dataTable({
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
 
                    $('#tablaProductos').dataTable({
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
                });//final del function
             function SeleccionarEmpleado(idEmpleado, nombreEmpleado){
                  $("#txtIdEmpleado").val(idEmpleado);
                  $("#txtNombreEmpleado").val(nombreEmpleado);
             }
             function SeleccionarCliente(idCliente, nombreCliente){
                  $("#txtIdCliente").val(idCliente);
                  $("#txtNombreCliente").val(nombreCliente);
             }
             function SeleccionarProducto(idProducto, Descripcion, Precio, Existencia){
                  $("#txtIdProducto").val(idProducto);
                  $("#txtdescripcion").val(Descripcion);
                  $("#txtprecio").val(Precio);
                  $("#txtexistencia").val(Existencia);
                  $("#txtcantidad").focus();
             }
             function Limpiar(){
                  $("#txtIdCliente").val("");
                  $("#txtNombreCliente").val("");
             }
             function LimpiarEmpleado(){
                  $("#txtIdEmpleado").val("");
                  $("#txtNombreEmpleado").val("");
             }
             function LimpiarProducto(){
                  $("#txtIdProducto").val("");
                  $("#txtdescripcion").val("");
                  $("#txtprecio").val("");
                  $("#txtexistencia").val("");
             }
        </script>
    </body>
</html>
