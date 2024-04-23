import 'package:dam_u3_practica1/modelos/profesor.dart';
import 'conexion.dart';
import 'package:sqflite/sqflite.dart';

class DBProfesor {
  // INSERTAR
  static Future<int> insertar(Profesor p) async{
    Database base = await Conexion.abrirDB();
    return base.insert("PROFESOR", p.toJSON(), conflictAlgorithm: ConflictAlgorithm.fail);
  }

  // ELIMINAR
  static Future<int> eliminar(String n) async{
    Database base = await Conexion.abrirDB();
    return base.delete("PROFESOR", where: "NPROFESOR=?", whereArgs: [n]);
  }

  // CONSULAR
  static Future<List<Profesor>> consultar() async{
    Database base = await Conexion.abrirDB();
    List<Map<String, dynamic>> r = await base.query("PROFESOR");

    return List.generate(
        r.length,
            (index){
          return Profesor(
              NProfesor: r[index]['NPROFESOR'],
              nombre: r[index]['NOMBRE'],
              carrera: r[index]['CARRERA']
          );
        }
    );
  }

  // ACTUALIZAR
  static Future<int> actualizar(Profesor p) async{
    Database base = await Conexion.abrirDB();

    return base.update(
        "PROFESOR",
        p.toJSON(),
        where: "NPROFESOR=?",
        whereArgs: [p.NProfesor.toString()]
    );
  }
}