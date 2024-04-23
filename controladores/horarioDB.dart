import 'package:dam_u3_practica1/modelos/horario.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHorario {
  // Crear conexion
  static Future<Database> _abrirDB() async {
    return openDatabase(
        join(await getDatabasesPath(), "horario.db"),
        onCreate: (db, version){
          return db.execute("CREATE TABLE HORARIO("
              "NHORARIO INTEGER PRIMARY KEY AUTOINCREMENT,"
              "NPROFESOR TEXT FOREIGN KEY,"
              "NMAT TEXT FOREIGN KEY,"
              "HORA TEXT,"
              "EDIFICIO TEXT,"
              "SALON TEXT,"
              "FOREIGN KEY (NPROFESOR) REFERENCES PROFESOR(NPROFESOR),"
              "FOREIGN KEY (NMAT) REFERENCES MATERIA(NMAT)"
              ")");
        },
        version: 1
    );
  }

  // INSERTAR
  static Future<int> insertar(Horario h) async{
    Database base = await _abrirDB();
    return base.insert("HORARIO", h.toJSON(), conflictAlgorithm: ConflictAlgorithm.fail);
  }

  // ELIMINAR
  static Future<int> eliminar(String n) async{
    Database base = await _abrirDB();
    return base.delete("HORARIO", where: "HORARIO=?", whereArgs: [n]);
  }

  // CONSULTAR
  static Future<List<Horario>> consultar() async{
    Database base = await _abrirDB();
    List<Map<String, dynamic>> r = await base.rawQuery("SELECT NHORARIO, NOMBRE, DESCRIPCION, HORA, EDIFICIO, SALON"
    "FROM HORARIO"
    "INNER JOIN PROFESOR ON HORARIO.NPROFESOR = PROFESOR.NPROFESOR"
    "INNER JOIN MATERIA ON HORARIO.NMAT = MATERIA.NMAT");
    return List.generate(r.length, (index) {
      return Horario(NHorario: r[index]['NHORARIO'],
          nombre: r[index]['NOMBRE'],
          descripcion: r[index]['DESCRIPCION'],
          hora: r[index]['HORA'],
          edificio: r[index]['EDIFICIO'],
          salon: r[index]['SALON']);

    });

  }
  // ACTUALIZAR
  static Future<int> actualizar(Horario h) async{
    Database base = await _abrirDB();

    return base.update(
        "HORARIO",
        h.toJSON(),
        where: "NHORARIO=?",
        whereArgs: [h.NHorario]
    );
  }

}