package Entidades;

/**
 *
 * @author dcruz
 */
public class Empleado {

// ATRIBUTOS ____________________________________
     private int id;
    private String cedula;
    private String codigo;
    private String nombre;
    private String telefono;
    private String correo;
    private String puesto;
    private double salario;
    private boolean existe;
     
     //Constrctores
     public Empleado(int id, String cedula, String codigo, String nombre, String telefono, String correo, String puesto, double salario) {
          this.id = id;
          this.cedula = cedula;
          this.codigo = codigo;
          this.nombre = nombre;
          this.telefono = telefono;
          this.correo = correo;
          this.puesto = puesto;
          this.salario = salario;
          this.existe = true;
     }
     
     public Empleado() {
          this.id = 0;
          this.cedula = "";
          this.codigo = "";
          this.nombre = "";
          this.telefono = "";
          this.correo = "";
          this.puesto = "";
          this.salario = 0.0;
          this.existe = false;
     }
     
     //Propiedades

     public int getId() {
          return id;
     }

     public void setId(int id) {
          this.id = id;
     }

     public String getCedula() {
          return cedula;
     }

     public void setCedula(String cedula) {
          this.cedula = cedula;
     }

     public String getCodigo() {
          return codigo;
     }

     public void setCodigo(String codigo) {
          this.codigo = codigo;
     }

     public String getNombre() {
          return nombre;
     }

     public void setNombre(String nombre) {
          this.nombre = nombre;
     }

     public String getTelefono() {
          return telefono;
     }

     public void setTelefono(String telefono) {
          this.telefono = telefono;
     }

     public String getCorreo() {
          return correo;
     }

     public void setCorreo(String correo) {
          this.correo = correo;
     }

     public String getPuesto() {
          return puesto;
     }

     public void setPuesto(String puesto) {
          this.puesto = puesto;
     }

     public double getSalario() {
          return salario;
     }

     public void setSalario(double salario) {
          this.salario = salario;
     }

     public boolean isExiste() {
          return existe;
     }

     public void setExiste(boolean existe) {
          this.existe = existe;
     }
     
    
    
    
}