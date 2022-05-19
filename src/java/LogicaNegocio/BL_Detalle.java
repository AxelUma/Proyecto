package LogicaNegocio;

import AccesoDatos.DA_Detalle;
import Entidades.DetalleFactura;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BL_Detalle {

    // ATRIBUTOS __________________________
    private String _mensaje;

    // PROPIEDADES ________________________
    public String getMensaje() {
        return _mensaje;
    }

    // CONSTRUCTOR
    public BL_Detalle() {
        _mensaje = "";
    }
    public List<DetalleFactura> ListarRegistros(String condicion) throws Exception{
        List<DetalleFactura> Datos;
        DA_Detalle accesodatos;
        try {
             accesodatos = new DA_Detalle();
             
            Datos = accesodatos.ListarRegistro(condicion);
        } 
        catch (Exception e) {
             Datos = null;
            throw e;
        }
        return Datos;
    }
    
    public int Eliminar(DetalleFactura Entidad) throws Exception{
        int resultado = 0;
        try {
             DA_Detalle DA = new DA_Detalle();
             resultado = DA.Eliminar(Entidad);
        } 
        catch (Exception e) {
             resultado = -1;
             throw e;
        }
        return resultado;
    }
    
    
} // clase
