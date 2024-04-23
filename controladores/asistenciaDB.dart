import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dam_u3_practica1/modelos/asistencia.dart';

class DBAsistencia {
  // Crear conexion
  static Future<Database> _abrirDB() async {
    return openDatabase(
        join(await getDatabasesPath(), "asistencia.db"),
        onCreate: (db, version){
          return db.execute("CREATE TABLE ASISTENCIA("
              "IDASISTENCIA INTEGER PRIMARY KEY AUTOINCREMENT,"
              "NHORARIO INTEGER FOREIGN KEY,"
              "FECHA TEXT,"
              "ASISTENCIA BOOLEAN,"
              "FOREIGN KEY (NHORARIO) REFERENCES HORARIO(NHORARIO)"
              ")");
        },
        version: 1
    );
  }

  // INSERTAR
  static Future<int> insertar(Asistencia a) async{
    Database base = await _abrirDB();
    return base.insert("ASISTENCIA", a.toJSON(), conflictAlgorithm: ConflictAlgorithm.fail);
  }
  // ELIMINAR
  // CONSULAR
  // ACTUALIZAR
}