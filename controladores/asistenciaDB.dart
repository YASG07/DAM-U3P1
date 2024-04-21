import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
  // ELIMINAR
  // CONSULAR
  // ACTUALIZAR
}