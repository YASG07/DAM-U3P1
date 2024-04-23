class Horario {
  int NHorario;
  String nombre;
  String descripcion;
  String hora;
  String edificio;
  String salon;

  Horario({
    required this.NHorario,
    required this.nombre,
    required this.descripcion,
    required this.hora,
    required this.edificio,
    required this.salon,
  });

  Map<String, dynamic> toJSON(){
    return{
      "nhorario" : NHorario,
      "nprofesor" : nombre,
      "nmat" : descripcion,
      "hora" : hora,
      "edificio" : edificio,
      "salon" : salon
    };
  }
}