package LogicaNegocio;

import AccesoDatos.DA_Empleado;
import Entidades.Empleado;
import java.sql.ResultSet;
import java.util.List;

/**
 *
 * @author dcruz
 */
public class BL_Empleado {
    private String _Mensaje;

    public String getMensaje() {
        return _Mensaje;
    }
    
    public int Insertar(Empleado Entidad) throws Exception{
            int Resultado= 0;

            try{
                
                DA_Empleado DA = new DA_Empleado();

                Resultado = DA.Insertar(Entidad);
                

            }catch(Exception ex){
                Resultado=-1;
                throw ex;
            }

            return Resultado;
    }
    
    public int Eliminar(Empleado Entidad) throws Exception {
        int Resultado= 0;
       
        try{

            DA_Empleado DA = new DA_Empleado();

            Resultado = DA.Eliminar(Entidad);
            _Mensaje = DA.getMensaje();
          

        }catch(Exception ex){
            Resultado=-1;
            throw ex;
        }

        return Resultado;
    }

    public List<Empleado> ListarRegistros(String condicion) throws Exception{
        List<Empleado> Datos;
       
        try{
            
            DA_Empleado DA = new DA_Empleado();

            Datos = DA.ListarRegistros(condicion);
            

        }catch (Exception ex){
            Datos=null;
            throw ex;
        }

        return Datos;
    }
    
    public Empleado ObtenerRegistro(String condicion) throws Exception{
        Empleado Entidad=null;
        
        try{
            
            DA_Empleado DA = new DA_Empleado();

            Entidad = DA.ObtenerRegistro(condicion);
            

        }catch (Exception ex){
            throw ex;
        }

        return Entidad;
    }
}
