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
  // CONSULAR
  // ACTUALIZAR
}