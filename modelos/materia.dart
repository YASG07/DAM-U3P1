class Materia {
  String NMat;
  String descripcion;

  Materia({
    required this.NMat,
    required this.descripcion
  });

  Map<String, dynamic> toJSON(){
    return {
      "nmat" : NMat,
      "descripcion" : descripcion
    };
  }
}