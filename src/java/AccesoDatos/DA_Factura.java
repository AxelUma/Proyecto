package AccesoDatos;

/**
 * @author gollo163
 */
import Entidades.DetalleFactura;
import Entidades.Factura;
import java.sql.*;
import java.util.*;

public class DA_Factura {

     public String getMensaje() {
          return _Mensaje;
     }
     private String _Mensaje;
     
     public DA_Factura() {
          _Mensaje = "";
     }
     
     public List<Factura> ListarRegistro(String condicion) throws Exception {
          ResultSet rs = null;
          Factura entidad;
          List<Factura> ListaF = new ArrayList<>();
          Connection _conexion = null;
          try {
               _conexion = ClaseConexion.getConnection();
               Statement st = _conexion.createStatement();
               String sentencia;
               sentencia = "Select NUMERO_FACTURA, F.ID_VENDEDOR, F.ID_CLIENTE, NOMBRE_C, NOMBRE_E, FECHA, ESTADO, TOTAL "
                                   + " FROM FACTURAS F "
                                   + " INNER JOIN CLIENTES C ON F.ID_CLIENTE = C.ID "
                                   + " INNER JOIN EMPLEADOS E ON F.ID_VENDEDOR = E.ID";
               if (!condicion.equals("")){
                    sentencia = String.format("%s where %s", sentencia,condicion);
               }
               rs = st.executeQuery(sentencia);
               while(rs.next()){
                    entidad = new Factura(rs.getInt("Numero_factura"),rs.getInt("id_vendedor"),rs.getInt("id_cliente"),rs.getString("nombre_c"), rs.getString("nombre_e"),rs.getDate("Fecha"), rs.getDouble("total"),rs.getString("Estado"));
                    ListaF.add(entidad);
               }
          } catch (Exception e) {
               throw e;
          } finally {
               if (_conexion != null){
                    ClaseConexion.close(_conexion);
               }
          }
          return ListaF;
     }
     
     public Factura ObtenerRegistro(String Condicion) throws Exception {
        ResultSet rs = null;
        Factura entidad = new Factura();
        String sentencia;
        Connection _conexion = null;
        try {
            _conexion = ClaseConexion.getConnection();
            Statement st = _conexion.createStatement();

            sentencia = "Select NUMERO_FACTURA, F.ID_VENDEDOR, F.ID_CLIENTE, NOMBRE_C, NOMBRE_E, FECHA, ESTADO, TOTAL "
                                   + " FROM FACTURAS F "
                                   + " INNER JOIN CLIENTES C ON F.ID_CLIENTE = C.ID "
                                   + " INNER JOIN EMPLEADOS E ON F.ID_VENDEDOR = E.ID";
            if (!Condicion.equals("")) {
                sentencia = String.format("%s WHERE %s", sentencia, Condicion);
            }
            rs = st.executeQuery(sentencia);
            if (rs.next()) {
                entidad.setIdFactura(rs.getInt("numero_factura"));
                entidad.setIdVendedor(rs.getInt("Id_vendedor"));
                entidad.setIdCliente(rs.getInt("Id_cliente"));
                entidad.setNombreCliente(rs.getString("Nombre_C"));
                entidad.setNombreEmpleado(rs.getString("Nombre_E"));
                entidad.setFecha(rs.getDate("Fecha"));
                entidad.setTotal(rs.getDouble("Total"));
                entidad.setEstado(rs.getString("Estado"));
                entidad.setExisteRegistro(false);
            } else {
                entidad.setExisteRegistro(false);
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (_conexion != null) {
                ClaseConexion.close(_conexion);
            }
        }
        return entidad;
    }
     
     public int Insertar(Factura EntidadFactura, DetalleFactura EntidadDetalle) throws Exception{
            CallableStatement CS;
            int resultado = 0;
            int idFactura = 0;
            Connection _Conexion=null;
            
            try{
                _Conexion=ClaseConexion.getConnection();
                
                _Conexion.setAutoCommit(false);
                CS=_Conexion.prepareCall("{call Guardar_Factura ( ? ,? ,? ,? ,?, ?, ? )}");

                CS.setInt(1, EntidadFactura.getIdFactura());
                CS.setInt(2, EntidadFactura.getIdVendedor());
                CS.setInt(3, EntidadFactura.getIdCliente());
                CS.setDate(4, EntidadFactura.getFecha());
                CS.setDouble(5, EntidadFactura.getTotal());
                CS.setString(6, EntidadFactura.getEstado());
                CS.setString(7, _Mensaje);
                
                
                CS.registerOutParameter(1, Types.INTEGER);
                
                resultado = CS.executeUpdate();
                idFactura = CS.getInt(1);
                
                CS=_Conexion.prepareCall("{call Guardar_Detalle ( ? , ? , ? , ? , ? )}");

                CS.setInt(1, idFactura);
                CS.setInt(2, EntidadDetalle.getIdProducto());
                CS.setInt(3, EntidadDetalle.getCantidad());
                CS.setDouble(4, (double) EntidadDetalle.getPrecio());
                CS.setString(5, _Mensaje);
                
                //registrar mensaje de salida
                CS.registerOutParameter(5, Types.VARCHAR);
                resultado = CS.executeUpdate();
                _Mensaje = CS.getString(5);
                _Conexion.commit();
                
            }catch (ClassNotFoundException | SQLException ex){
                _Conexion.rollback();
                throw ex;
            }finally{
                if (_Conexion != null) ClaseConexion.close(_Conexion);
            }
            return idFactura;
        }//fin de insertar
     
     public int ModificarCliente(Factura EntidadFactura) throws Exception{
            int idFactura = 0;
            Connection _Conexion=null;
            
            try{
                _Conexion=ClaseConexion.getConnection();
                PreparedStatement PS = _Conexion.prepareCall("update Facturas set ID_CLIENTE = ?, ID_VENDEDOR = ? where NUMERO_FACTURA = ?");
                
                PS.setInt(1, EntidadFactura.getIdCliente());
                PS.setInt(2, EntidadFactura.getIdVendedor());
                PS.setInt(3, EntidadFactura.getIdFactura());
                
                PS.executeUpdate();
                idFactura = EntidadFactura.getIdFactura();
                
            }catch (Exception ex){
                throw ex;
            }finally{
                if (_Conexion != null) {
                     ClaseConexion.close(_Conexion);
                }
            }
            return idFactura;
        }//fin de insertar
     
     public int ModificarEstado(Factura EntidadFactura) throws Exception{
            int resultado = 0;
            Connection _Conexion=null;
            
            try{
                _Conexion=ClaseConexion.getConnection();
                PreparedStatement PS = _Conexion.prepareCall("update Facturas set Estado = ? where NUMERO_FACTURA = ?");
                
                PS.setString(1, EntidadFactura.getEstado());
                PS.setInt(2, EntidadFactura.getIdFactura());
                
                resultado = PS.executeUpdate();
                
            }catch (Exception ex){
                 resultado = -1;
                throw ex;
            }finally{
                if (_Conexion != null) {
                     ClaseConexion.close(_Conexion);
                }
            }
            return resultado;
        }//fin de insertar
 
     
}
