package AccesoDatos;


import Entidades.Producto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author dcruz
 */
public class DA_Productos {
    //"Atributos"
        private String _Mensaje="";
    //*******************************************

    public String getMensaje() {
        return _Mensaje;
    }

    //"Constructores"
        public DA_Productos() {
            _Mensaje="";
        }
    //*******************************************

    //"Metodos"
        public int Insertar(Producto EntidadProducto) throws Exception{
            ResultSet RS=null;
            CallableStatement CS=null;
            int resultado = 0;
            Connection _Conexion=null;
            
            try{
                _Conexion=ClaseConexion.getConnection();
                CS=_Conexion.prepareCall("{call Guardar_Producto(?,?,?,?,?,?,?,?)}");

                CS.setInt(1, EntidadProducto.getId());
                CS.setString(2, EntidadProducto.getCodigo());
                CS.setString(3, EntidadProducto.getProducto());
                CS.setString(4, EntidadProducto.getModelo());
                CS.setInt(5, EntidadProducto.getCantidad());
                CS.setDouble(6, EntidadProducto.getPrecioCompra());
                CS.setDouble(7, EntidadProducto.getPrecioVenta());
                
                CS.setString(8, _Mensaje);
           
                resultado = CS.executeUpdate();
                
            }catch (Exception ex){
                resultado=-1;
                throw ex;
            }finally{
                if (_Conexion != null) ClaseConexion.close(_Conexion);
            }
            return resultado;
        }//fin de insertar


        public int Eliminar(Producto EntidadProducto) throws Exception {
            CallableStatement CS=null;
            int resultado = 0;
            Connection _Conexion=null;
            try{
                _Conexion=ClaseConexion.getConnection();
                CS=_Conexion.prepareCall("{call Eliminar_Producto(?,?)}");
                             
                CS.setInt(1, EntidadProducto.getId());
                CS.setString(2, _Mensaje);
                CS.registerOutParameter(2, Types.VARCHAR);
                resultado = CS.executeUpdate();

                _Mensaje=CS.getString(2);
                
            }catch (Exception ex){
                resultado=-1;
                throw  ex;
            }finally{
                if (_Conexion != null) ClaseConexion.close(_Conexion);
            }
            return resultado;
        }//fin de eliminar

        public List<Producto> ListarRegistros(String Condicion) throws Exception{
            ResultSet RS=null;
            Producto Entidad;
            List<Producto> lista=new ArrayList<>();
            Connection _Conexion=null;
            try{
                _Conexion=ClaseConexion.getConnection(); 
                Statement ST = _Conexion.createStatement();
                String Sentencia;

                Sentencia = "SELECT ID_INVENTARIO, CODIGO, PRODUCTO, MODELO, CANTIDAD, PRECIO_COMPRA, PRECIO_VENTA FROM INVENTARIO";
                if (!Condicion.equals("")) {
                    Sentencia = String.format("%s WHERE %s", Sentencia, Condicion);
                }

                RS=ST.executeQuery(Sentencia);
                while(RS.next()){
                    Entidad=new Producto(RS.getInt(1), RS.getString(2), RS.getString(3), RS.getString(4), RS.getInt(5), RS.getDouble(6), RS.getDouble(7));
                    lista.add(Entidad);
                }
            }catch(Exception ex){
                throw ex;
            }finally{
                if (_Conexion != null) ClaseConexion.close(_Conexion);
            }
            return lista;
        }
        
        public Producto ObtenerRegistro(String condicion) throws SQLException, Exception {
            ResultSet RS=null;
            Producto EntidadProducto=new Producto();
            String vlc_Sentencia;
            Connection _Conexion=null;
            vlc_Sentencia = "SELECT ID_INVENTARIO, CODIGO, PRODUCTO, MODELO, CANTIDAD, PRECIO_COMPRA, PRECIO_VENTA FROM INVENTARIO";

            if (!condicion.equals("")) {
                vlc_Sentencia = String.format("%s WHERE %s", vlc_Sentencia, condicion);
            }

            try{
                _Conexion=ClaseConexion.getConnection();
                Statement ST = _Conexion.createStatement();
                RS=ST.executeQuery(vlc_Sentencia);
                if(RS.next()){
                    EntidadProducto.setId(RS.getInt(1));
                    EntidadProducto.setCodigo(RS.getString(2));
                    EntidadProducto.setProducto(RS.getString(3));
                    EntidadProducto.setModelo(RS.getString(4));
                    EntidadProducto.setCantidad(RS.getInt(5));
                    EntidadProducto.setPrecioCompra(RS.getDouble(6));
                    EntidadProducto.setPrecioVenta(RS.getDouble(7));
                    
                    EntidadProducto.setExisteRegistro(true);
                    
                }else{
                    EntidadProducto.setExisteRegistro(false);
                    
                }
                   
            }catch(Exception ex){
                throw ex;
            }finally{
                if (_Conexion != null) ClaseConexion.close(_Conexion);
            }
            return EntidadProducto;
        }
}
