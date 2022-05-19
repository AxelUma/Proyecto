
package Entidades;

public class DetalleFactura {

    // ATRIBUTOS
    
    private int idFactura;
    private int idProducto;
    private int idOrden;
    private int cantidad;
    
    private double precio;
    private boolean existeRegistro;
    
    private String nombreProducto; // No mapea ningún campo de la BD
    private String nombreMecanico;
    
    
    
    // CONSTRUCTORES

    public DetalleFactura() {
        idFactura = 0;
        idProducto = 0;
        nombreProducto = "";
        cantidad = 0;
        precio = 0;
        existeRegistro = false;
    }

    public DetalleFactura(int IdFactura, int IdProducto, String NombreProducto, int Cantidad, int Precio) {
        this.idFactura = IdFactura;
        this.idProducto = IdProducto;
        this.nombreProducto = NombreProducto;
        this.cantidad = Cantidad;
        this.precio = Precio;
        existeRegistro = true; // no se recibe como atributo, se configura por defecto
    }
    
    
    
    // PROPIEDADES

    public int getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(int IdFactura) {
        this.idFactura = IdFactura;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int IdProducto) {
        this.idProducto = IdProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String NombreProducto) {
        this.nombreProducto = NombreProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int Catnidad) {
        this.cantidad = Catnidad;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double Precio) {
        this.precio = Precio;
    }

    public boolean isExisteRegistro() {
        return existeRegistro;
    }

    public void setExisteRegistro(boolean ExisteRegistro) {
        this.existeRegistro = ExisteRegistro;
    }

     public int getIdOrden() {
          return idOrden;
     }

     public void setIdOrden(int idOrden) {
          this.idOrden = idOrden;
     }

     public String getNombreMecanico() {
          return nombreMecanico;
     }

     public void setNombreMecanico(String nombreMecanico) {
          this.nombreMecanico = nombreMecanico;
     }
    
    
    
}
