class Asistencia {
  int idAsistencia;
  int NHorario;
  String fecha;
  bool asistencia;

  Asistencia({
    required this.idAsistencia,
    required this.NHorario,
    required this.fecha,
    required this.asistencia
  });

  Map<String, dynamic> toJSON(){
    return {
      "idasistencia" : idAsistencia,
      "nhorario" : NHorario,
      "fecha" : fecha,
      "asistencia" : asistencia,
    };
  }
}