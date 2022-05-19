package AccesoDatos;


import Entidades.Empleado;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author dcruz
 */
public class DA_Empleado {
    //"Atributos"
        private String _Mensaje="";
    //*******************************************

    public String getMensaje() {
        return _Mensaje;
    }

    //"Constructores"
        public DA_Empleado() {
            _Mensaje="";
        }
    //*******************************************

    //"Metodos"
        public int Insertar(Empleado entidad) throws Exception{
            ResultSet RS=null;
            CallableStatement CS=null;
            int resultado = 0;
            Connection _Conexion=null;
            
            try{
                _Conexion=ClaseConexion.getConnection();
                CS=_Conexion.prepareCall("{call Guardar_Empleado(?,?,?,?,?,?,?,?,?)}");

                CS.setInt(1, entidad.getId());
                CS.setString(2, entidad.getCedula());
                CS.setString(3, entidad.getCodigo());
                CS.setString(4, entidad.getNombre());
                CS.setString(5, entidad.getTelefono());
                CS.setString(6, entidad.getCorreo());
                CS.setString(7, entidad.getPuesto());
                CS.setDouble(8, entidad.getSalario());
                
                CS.setString(9, _Mensaje);
           
                resultado = CS.executeUpdate();
                
            }catch (Exception ex){
                resultado=-1;
                throw ex;
            }finally{
                if (_Conexion != null) ClaseConexion.close(_Conexion);
            }
            return resultado;
        }//fin de insertar


        public int Eliminar(Empleado Entidad) throws Exception {
            CallableStatement CS=null;
            int resultado = 0;
            Connection _Conexion=null;
            try{
                _Conexion=ClaseConexion.getConnection();
                CS=_Conexion.prepareCall("{call Eliminar_Empleado(?,?)}");
                             
                CS.setInt(1, Entidad.getId());
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

        public List<Empleado> ListarRegistros(String Condicion) throws Exception{
            ResultSet RS=null;
            Empleado Entidad;
            List<Empleado> lista=new ArrayList<>();
            Connection _Conexion=null;
            try{
                _Conexion=ClaseConexion.getConnection(); 
                Statement ST = _Conexion.createStatement();
                String Sentencia;

                Sentencia = "SELECT ID, CEDULA, CODIGO, NOMBRE_E, TELEFONO, CORREO, PUESTO, SALARIO FROM EMPLEADOS";
                if (!Condicion.equals("")) {
                    Sentencia = String.format("%s WHERE %s", Sentencia, Condicion);
                }

                RS=ST.executeQuery(Sentencia);
                while(RS.next()){
                    Entidad=new Empleado(RS.getInt(1), RS.getString(2), RS.getString(3), RS.getString(4), RS.getString(5), RS.getString(6), RS.getString(7), RS.getDouble(8));
                    lista.add(Entidad);
                }
            }catch(Exception ex){
                throw ex;
            }finally{
                if (_Conexion != null) ClaseConexion.close(_Conexion);
            }
            return lista;
        }
        
        public Empleado ObtenerRegistro(String condicion) throws SQLException, Exception {
            ResultSet RS=null;
            Empleado Entidad=new Empleado();
            String vlc_Sentencia;
            Connection _Conexion=null;
            vlc_Sentencia = "SELECT ID, CEDULA, CODIGO, NOMBRE_E, TELEFONO, CORREO, PUESTO, SALARIO FROM EMPLEADOS";

            if (!condicion.equals("")) {
                vlc_Sentencia = String.format("%s WHERE %s", vlc_Sentencia, condicion);
            }

            try{
                _Conexion=ClaseConexion.getConnection();
                Statement ST = _Conexion.createStatement();
                RS=ST.executeQuery(vlc_Sentencia);
                if(RS.next()){
                    Entidad.setId(RS.getInt(1));
                    Entidad.setCedula(RS.getString(2));
                    Entidad.setCodigo(RS.getString(3));
                    Entidad.setNombre(RS.getString(4));
                    Entidad.setTelefono(RS.getString(5));
                    Entidad.setCorreo(RS.getString(6));
                    Entidad.setPuesto(RS.getString(7));
                    Entidad.setSalario(RS.getDouble(8));
                    
                    Entidad.setExiste(true);
                    
                }else{
                    Entidad.setExiste(false);
                    
                }
                   
            }catch(Exception ex){
                throw ex;
            }finally{
                if (_Conexion != null) ClaseConexion.close(_Conexion);
            }
            return Entidad;
        }
}
