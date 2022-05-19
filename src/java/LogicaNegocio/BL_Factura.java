package LogicaNegocio;

import AccesoDatos.DA_Detalle;
import AccesoDatos.DA_Factura;
import Entidades.DetalleFactura;
import Entidades.Factura;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BL_Factura {

    // ATRIBUTOS __________________________
    private String _mensaje;

    // PROPIEDADES ________________________
    public String getMensaje() {
        return _mensaje;
    }

    // CONSTRUCTOR
    public BL_Factura() {
        _mensaje = "";
    }

    
    public List<Factura> ListarRegistros(String condicion) throws Exception{
        List<Factura> Datos;
        try {
             DA_Factura DA = new DA_Factura();
            Datos = DA.ListarRegistro(condicion);
        } 
        catch (Exception e) {
             Datos = null;
            throw e;
        }
        return Datos;
    }
    
    public Factura ObtenerRegistro(String condicion) throws Exception{
        Factura entidad = null;
        try {
             DA_Factura DA = new DA_Factura();
            entidad = DA.ObtenerRegistro(condicion);
        } 
        catch (Exception e) {
            throw e;
        }
        return entidad;
    }
    
    public int Insertar(Factura Entidad, DetalleFactura EntidadDetalle) throws Exception{
        int resultado = 0;
        try {
             DA_Factura DA = new DA_Factura();
            resultado = DA.Insertar(Entidad,EntidadDetalle);
            _mensaje = DA.getMensaje();
        } 
        catch (Exception ex) {
             resultado = -1;
            throw ex;
        }
        return resultado;
    }
    
    public int ModificarCliente(Factura Entidad) throws Exception{
        int resultado = 0;
        try {
             DA_Factura DA = new DA_Factura();
            resultado = DA.ModificarCliente(Entidad);
        } 
        catch (Exception ex) {
            throw ex;
        }
        return resultado;
    }
    
    public int ModifcarEstado(Factura Entidad) throws Exception{
        int resultado = 0;
        
        try {
             DA_Factura DA = new DA_Factura();
             resultado = DA.ModificarEstado(Entidad);
        } 
        catch (Exception ex) {
            throw ex;
        }
        return resultado;
    }
    
} // clase
