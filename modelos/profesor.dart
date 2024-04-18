class Profesor {
  String NProfesor;
  String nombre;
  String carrera;

  Profesor({
    required this.NProfesor,
    required this.nombre,
    required this.carrera
  });

  Map<String, dynamic> toJSON(){
    return{
      "nprofesor" : NProfesor,
      "nombre" : nombre,
      "carrera" : carrera
    };
  }
}