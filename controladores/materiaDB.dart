import 'package:dam_u3_practica1/modelos/materia.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBMateria {
  // Crear conexion
  static Future<Database> _abrirDB() async {
    return openDatabase(
      join(await getDatabasesPath(), "materia.db"),
      onCreate: (db, version){
        return db.execute("CREATE TABLE MATERIA("
            "NMAT TEXT PRIMARY KEY,"
            "DESCRIPCION TEXT"
            ")");
      },
      version: 1
    );
  }

  // INSERTAR
  static Future<int> insertar(Materia m) async{
    Database base = await _abrirDB();
    return base.insert("MATERIA", m.toJSON(), conflictAlgorithm: ConflictAlgorithm.fail);
  }

  // ELIMINAR
  static Future<int> eliminar(String n) async{
    Database base = await _abrirDB();
    return base.delete("MATERIA", where: "NMAT=?", whereArgs: [n]);
  }

  // CONSULAR
  static Future<List<Materia>> consultar() async{
    Database base = await _abrirDB();
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
    Database base = await _abrirDB();

    return base.update(
        "MATERIA",
        m.toJSON(),
      where: "NMAT=?",
      whereArgs: [m.NMat]
    );
  }
}