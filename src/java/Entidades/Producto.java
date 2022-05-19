package Entidades;

/**
 *
 * @author dcruz
 */
public class Producto {

        private int Id;
    private String codigo;
    private String producto;
    private String modelo;
    private int cantidad;
    private double precioCompra;
    private double precioVenta;
    private boolean existeRegistro;
    
    public Producto(int Id, String codigo, String producto, String modelo, int cantidad, double precioCompra, double precioVenta) {
          this.Id = Id;
          this.codigo = codigo;
          this.producto = producto;
          this.modelo = modelo;
          this.cantidad = cantidad;
          this.precioCompra = precioCompra;
          this.precioVenta = precioVenta;
     }

     public Producto() {
          this.Id = 0;
          this.codigo = "";
          this.producto = "";
          this.modelo = "";
          this.cantidad = 0;
          this.precioCompra = 0.0;
          this.precioVenta = 0.0;
     }
    
     public int getId() {
          return Id;
     }

     public void setId(int Id) {
          this.Id = Id;
     }

     public String getCodigo() {
          return codigo;
     }

     public void setCodigo(String codigo) {
          this.codigo = codigo;
     }

     public String getProducto() {
          return producto;
     }

     public void setProducto(String producto) {
          this.producto = producto;
     }

     public String getModelo() {
          return modelo;
     }

     public void setModelo(String modelo) {
          this.modelo = modelo;
     }

     public int getCantidad() {
          return cantidad;
     }

     public void setCantidad(int cantidad) {
          this.cantidad = cantidad;
     }

     public double getPrecioCompra() {
          return precioCompra;
     }

     public void setPrecioCompra(double precioCompra) {
          this.precioCompra = precioCompra;
     }

     public double getPrecioVenta() {
          return precioVenta;
     }

     public void setPrecioVenta(double precioVenta) {
          this.precioVenta = precioVenta;
     }

     public boolean isExisteRegistro() {
          return existeRegistro;
     }

     public void setExisteRegistro(boolean existeRegistro) {
          this.existeRegistro = existeRegistro;
     }
}