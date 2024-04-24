import '../modelos/asistenciaHorario.dart';
import 'conexion.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dam_u3_practica1/modelos/asistencia.dart';

class DBAsistencia {
  // INSERTAR
  static Future<int> insertar(Asistencia a) async{
    Database base = await Conexion.abrirDB();
    return base.insert("ASISTENCIA", a.toJSON(), conflictAlgorithm: ConflictAlgorithm.fail);
  }
  // ELIMINAR
  static Future<int> eliminar(int id) async {
    Database base = await Conexion.abrirDB();
    return base.delete("ASISTENCIA", where: "IDASISTENCIA=?", whereArgs: [id]);
  }
  // CONSULTAR
  static Future<List<AsistenciaHorario>> consultar() async{
    Database base = await Conexion.abrirDB();
    List<Map<String, dynamic>> r = await base.query(
        "ASISTENCIA INNER JOIN HORARIO ON ASISTENCIA.NHORARIO = HORARIO.NHORARIO "
            "INNER JOIN PROFESOR ON HORARIO.NPROFESOR = PROFESOR.NPROFESOR",
        columns: ["ASISTENCIA.IDASISTENCIA",
                  "ASISTENCIA.FECHA",
                  "ASISTENCIA.ASISTIO",
                  "HORARIO.HORA",
                  "PROFESOR.NOMBRE"]);
    return List.generate(r.length, (index) {
      return AsistenciaHorario(
          idAsistencia: r[index]['IDASISTENCIA'],
          fecha: r[index]['FECHA'],
          asistio: r[index]['ASISTIO'],
          hora: r[index]['HORA'],
          nombre: r[index]['NOMBRE']
      );
    });
  }
  // ACTUALIZAR
  static Future<int> actualizar(Asistencia a) async{
    Database base = await Conexion.abrirDB();
    return base.update("ASISTENCIA", a.toJSON(),
        where: "IDASISTENCIA=?", whereArgs: [a.idAsistencia]);
  }
}