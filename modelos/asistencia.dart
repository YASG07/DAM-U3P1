class Asistencia {
  int idAsistencia;
  int NHorario;
  String fecha;
  bool asistio;

  Asistencia({
    required this.idAsistencia,
    required this.NHorario,
    required this.fecha,
    required this.asistio
  });

  Map<String, dynamic> toJSON(){
    return {
      "nhorario" : NHorario,
      "fecha" : fecha,
      "asistio" : asistio,
    };
  }
}