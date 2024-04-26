import '/modelos/materia.dart';
import 'conexion.dart';
import 'package:sqflite/sqflite.dart';

class DBMateria {
  // INSERTAR
  static Future<int> insertar(Materia m) async{
    Database base = await Conexion.abrirDB();
    return base.insert("MATERIA", m.toJSON(), conflictAlgorithm: ConflictAlgorithm.fail);
  }

  // ELIMINAR
  static Future<int> eliminar(String n) async{
    Database base = await Conexion.abrirDB();
    return base.delete("MATERIA", where: "NMAT=?", whereArgs: [n]);
  }

  // CONSULAR
  static Future<List<Materia>> consultar() async{
    Database base = await Conexion.abrirDB();
    List<Map<String, dynamic>> r = await base.query("MATERIA");

    return List.generate(
        r.length,
        (index){
          return Materia(
              NMat: r[index]['NMAT'],
              descripcion: r[index]['DESCRIPCION']
          );
        }
    );
  }

  // ACTUALIZAR
  static Future<int> actualizar(Materia m) async{
    Database base = await Conexion.abrirDB();

    return base.update(
        "MATERIA",
        m.toJSON(),
      where: "NMAT=?",
      whereArgs: [m.NMat]
    );
  }
}