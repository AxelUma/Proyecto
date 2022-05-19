package Entidades;

import java.sql.Date;
/*  Hay varios objetos para manejar fechas, en este caso como son fechas
    que manipulamos diretamente de la BD debemos agregar este import, para 
    que las fechas sean compatibles con el driver de la BD que estamos manejando.
    Si no hacemos ese import, al declarar el atributo fecha automáticamente
    nos va a sugerir el import java.util.Date, pero el de UTIL es un objeto
    de fecha GENÉRICO, el que nos sirve es el de SQL.
*/

public class Factura {
    
    // ATRIBUTOS
    private int idFactura;
    private int idVendedor;
    private int idCliente;
    private Date fecha;
    private double total;
    private String estado;
    private boolean existeRegistro;
    
    private String nombreCliente; // No es un campo de la BD
    private String nombreEmpleado; // No es un campo de la BD
    
    // CONSTRUCTORES

    public Factura() {
        idFactura = 0;
        idVendedor = 0;
        idCliente = 0;
        nombreCliente = "";
        fecha = null; // Para obtener la fecha actual se usa getTime() de la clase Date
        estado = "";
        existeRegistro = false;
    }

    public Factura(int IdFactura,  int IdVendedor, int IdCliente, String NombreCliente, String NombreEmpleado, Date Fecha, double Total, String Estado) {
        this.idFactura = IdFactura;
        this.idCliente = IdCliente;
        this.idVendedor = IdVendedor;
        this.nombreCliente = NombreCliente;
        this.nombreEmpleado = NombreEmpleado;
        this.fecha = Fecha;
        this.total = Total;
        this.estado = Estado;
        existeRegistro = true; // no se recibe por parámetro
    }
    
    
    // PROPIEDADES
    public int getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(int IdFactura) {
        this.idFactura = IdFactura;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int IdCliente) {
        this.idCliente = IdCliente;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String NombreCliente) {
        this.nombreCliente = NombreCliente;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date Fecha) {
        this.fecha = Fecha;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String Estado) {
        this.estado = Estado;
    }

     public int getIdVendedor() {
          return idVendedor;
     }

     public void setIdVendedor(int idVendedor) {
          this.idVendedor = idVendedor;
     }

     public double getTotal() {
          return total;
     }

     public void setTotal(double total) {
          this.total = total;
     }

     public String getNombreEmpleado() {
          return nombreEmpleado;
     }

     public void setNombreEmpleado(String nombreEmpleado) {
          this.nombreEmpleado = nombreEmpleado;
     }

    public boolean isExisteRegistro() {
        return existeRegistro;
    }

    public void setExisteRegistro(boolean ExisteRegistro) {
        this.existeRegistro = ExisteRegistro;
    }
    
}
