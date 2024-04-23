import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Conexion {
  static Future<Database> abrirDB() async{
       return openDatabase(
           join(await getDatabasesPath(),"asistencias.db"),
           onCreate: (db, version){
             return _script(db);
           },
           version: 2
       );
     }
  static Future<void> _script(Database db) async{
     db.execute("CREATE TABLE MATERIA("
         "NMAT TEXT PRIMARY KEY,"
         "DESCRIPCION TEXT"
         ")");
     db.execute("CREATE TABLE HORARIO("
         "NHORARIO INTEGER PRIMARY KEY AUTOINCREMENT,"
         "NPROFESOR TEXT,"
         "NMAT TEXT,"
         "HORA TEXT,"
         "EDIFICIO TEXT,"
         "SALON TEXT,"
         "FOREIGN KEY (NPROFESOR) REFERENCES PROFESOR(NPROFESOR),"
         "FOREIGN KEY (NMAT) REFERENCES MATERIA(NMAT)"
         ")");
     db.execute("CREATE TABLE ASISTENCIA("
         "IDASISTENCIA INTEGER PRIMARY KEY AUTOINCREMENT,"
         "NHORARIO INTEGER FOREIGN KEY,"
         "FECHA TEXT,"
         "ASISTENCIA BOOLEAN,"
         "FOREIGN KEY (NHORARIO) REFERENCES HORARIO(NHORARIO)"
         ")");
     db.execute("CREATE TABLE PROFESOR("
         "NPROFESOR TEXT PRIMARY KEY,"
         "NOMBRE TEXT,"
         "CARRERA TEXT"
         ")");
  }
}