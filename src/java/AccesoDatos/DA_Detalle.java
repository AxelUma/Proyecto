package AccesoDatos;

/**
 * @author gollo163
 */
import Entidades.DetalleFactura;
import java.sql.*;
import java.util.*;

public class DA_Detalle {

     public String getMensaje() {
          return _Mensaje;
     }
     private String _Mensaje;
     
     public DA_Detalle() {
          _Mensaje = "";
     }
     
     public List<DetalleFactura> ListarRegistro(String condicion) throws Exception {
          ResultSet rs = null;
          DetalleFactura entidad;
          List<DetalleFactura> Lista = new ArrayList<>();
          Connection _conexion = null;
          try {
               _conexion = ClaseConexion.getConnection();
               Statement st = _conexion.createStatement();
               String sentencia;
               sentencia = "Select ID_FACTURA, DF.ID_PRODUCTO, PRODUCTO, CANTIDAD_PEDIDO, PRECIO_VENTA "
                                   + " FROM DETALLE_FACTURA DF "
                                   + " INNER JOIN INVENTARIO P ON DF.ID_PRODUCTO = P.ID_INVENTARIO";
               if (!condicion.equals("")){
                    sentencia = String.format("%s where %s", sentencia,condicion);
               }
               rs = st.executeQuery(sentencia);
               while(rs.next()){
                    entidad = new DetalleFactura(rs.getInt("ID_FACTURA"),rs.getInt("id_producto"),rs.getString("producto"),rs.getInt("cantidad_pedido"),rs.getInt("precio_venta"));
                    Lista.add(entidad);
               }
          } catch (Exception e) {
               throw e;
          } finally {
               if (_conexion != null){
                    ClaseConexion.close(_conexion);
               }
          }
          return Lista;
     }
     
     public int Eliminar(DetalleFactura Entidad) throws Exception{
            CallableStatement CS = null;
            int resultado = 0;
            Connection _Conexion = null;
            
            try{
                _Conexion=ClaseConexion.getConnection();
                CS = _Conexion.prepareCall("{call Eliminar_Detalle( ? , ? , ? )}");
                
                CS.setInt(1, Entidad.getIdFactura());
                CS.setInt(2, Entidad.getIdProducto());
                CS.setString(3, _Mensaje);
                
                resultado = CS.executeUpdate();
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
