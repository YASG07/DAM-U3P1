import '/modelos/horario.dart';
import 'conexion.dart';
import 'package:sqflite/sqflite.dart';

class DBHorario {
  // INSERTAR
  static Future<int> insertar(Horario h) async{
    Database base = await Conexion.abrirDB();
    return base.insert("HORARIO", h.toJSON(), conflictAlgorithm: ConflictAlgorithm.fail);
  }

  // ELIMINAR
  static Future<int> eliminar(int n) async{
    Database base = await Conexion.abrirDB();
    return base.delete("HORARIO", where: "NHORARIO=?", whereArgs: [n]);
  }

  //consultar
  static Future<List<Horario>> consultar() async {
    Database base = await Conexion.abrirDB();
    List<Map<String, dynamic>> r = await base.rawQuery(
        "SELECT HORARIO.NHORARIO, PROFESOR.NOMBRE AS NOMBRE_PROFESOR, MATERIA.DESCRIPCION, HORARIO.HORA, HORARIO.EDIFICIO, HORARIO.SALON "
            "FROM HORARIO "
            "INNER JOIN PROFESOR ON HORARIO.NPROFESOR = PROFESOR.NPROFESOR "
            "INNER JOIN MATERIA ON HORARIO.NMAT = MATERIA.NMAT");
    return List.generate(r.length, (index) {
      return Horario(
          NHorario: r[index]['NHORARIO'],
          nombre: r[index]['NOMBRE_PROFESOR'],
          descripcion: r[index]['DESCRIPCION'],
          hora: r[index]['HORA'],
          edificio: r[index]['EDIFICIO'],
          salon: r[index]['SALON']);
    });
  }

  //consultar por materia
  static Future<List<Horario>> consultarPorMateria(String materia) async{
    Database base = await Conexion.abrirDB();
    List<Map<String, dynamic>> r = await base.query(
      "HORARIO INNER JOIN PROFESOR ON HORARIO.NPROFESOR = PROFESOR.NPROFESOR "
          "INNER JOIN MATERIA ON HORARIO.NMAT = MATERIA.NMAT",
      columns: ["HORARIO.NHORARIO",
                "PROFESOR.NOMBRE",
                "MATERIA.DESCRIPCION",
                "HORARIO.HORA",
                "HORARIO.EDIFICIO",
                "HORARIO.SALON"],
      where: "MATERIA.DESCRIPCION=?", whereArgs: [materia]
    );
    return List.generate(r.length, (index) {
      return Horario(
          NHorario: r[index]['NHORARIO'],
          nombre: r[index]['NOMBRE'],
          descripcion: r[index]['DESCRIPCION'],
          hora: r[index]['HORA'],
          edificio: r[index]['EDIFICIO'],
          salon: r[index]['SALON']);
    });
  }

  // ACTUALIZAR
  static Future<int> actualizar(Horario h, int ac) async{
    Database base = await Conexion.abrirDB();

    return base.update(
        "HORARIO",
        h.toJSON(),
        where: "NHORARIO=?",
        whereArgs: [ac]
    );
  }

}