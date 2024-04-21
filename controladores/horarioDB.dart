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
  // ELIMINAR
  // CONSULAR
  // ACTUALIZAR
}