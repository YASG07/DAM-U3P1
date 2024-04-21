import 'package:dam_u3_practica1/modelos/profesor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProfesor {
  // Crear conexion
  static Future<Database> _abrirDB() async {
    return openDatabase(
        join(await getDatabasesPath(), "profesor.db"),
        onCreate: (db, version){
          return db.execute("CREATE TABLE PROFESOR("
              "NPROFESOR TEXT PRIMARY KEY,"
              "NOMBRE TEXT,"
              "CARRERA TEXT"
              ")");
        },
        version: 1
    );
  }

  // INSERTAR
  static Future<int> insertar(Profesor p) async{
    Database base = await _abrirDB();
    return base.insert("PROFESOR", p.toJSON(), conflictAlgorithm: ConflictAlgorithm.fail);
  }

  // ELIMINAR
  static Future<int> eliminar(String n) async{
    Database base = await _abrirDB();
    return base.delete("PROFESOR", where: "NPROFESOR=?", whereArgs: [n]);
  }

  // CONSULAR
  static Future<List<Profesor>> consultar() async{
    Database base = await _abrirDB();
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
    Database base = await _abrirDB();

    return base.update(
        "PROFESOR",
        p.toJSON(),
        where: "NPROFESOR=?",
        whereArgs: [p.NProfesor.toString()]
    );
  }
}