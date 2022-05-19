package Entidades;

public class Cliente {

     // ATRIBUTOS ____________________________________
     
    private int id;
    private String cedula;
    private String nombre;
    private String telefono;
    private String correo;
    private boolean existe;

    // CONSTRUCTORES ________________________________
   public Cliente(int id, String cedula, String nombre, String telefono, String correo) {
          this.id = id;
          this.cedula = cedula;
          this.nombre = nombre;
          this.telefono = telefono;
          this.correo = correo;
          this.existe = true;
     }
   
   public Cliente() {
          this.id = 0;
          this.cedula = "";
          this.nombre = "";
          this.telefono = "";
          this.correo = "";
          this.existe = false;
     }
    
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

     public boolean isExiste() {
          return existe;
     }
     public void setExiste(boolean existe) {
          this.existe = existe;
     }
     
     
    // SOBRESCRIBIR MÉTODOS _______________________________
    @Override
    public String toString() {
        return id + " " + nombre;
    }

}
