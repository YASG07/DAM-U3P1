class Horario {
  int NHorario;
  String NProfesor;
  String NMat;
  String hora;
  String edificio;
  String salon;

  Horario({
    required this.NHorario,
    required this.NProfesor,
    required this.NMat,
    required this.hora,
    required this.edificio,
    required this.salon,
  });

  Map<String, dynamic> toJSON(){
    return{
      "nhorario" : NHorario,
      "nprofesor" : NProfesor,
      "nmat" : NMat,
      "hora" : hora,
      "edificio" : edificio,
      "salon" : salon
    };
  }
}