import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Conexion {
  static Future<Database> abrirDB() async{
       return openDatabase(
           join(await getDatabasesPath(),"registro.db"),
           onCreate: (db, version){
             return _script(db);
           },
           version: 1
       );
     }
  static Future<void> _script(Database db) async{
     await db.execute("CREATE TABLE MATERIA("
         "NMAT TEXT PRIMARY KEY,"
         "DESCRIPCION TEXT"
         ")");
     await db.execute("CREATE TABLE HORARIO("
         "NHORARIO INTEGER PRIMARY KEY AUTOINCREMENT,"
         "NPROFESOR TEXT,"
         "NMAT TEXT,"
         "HORA TEXT,"
         "EDIFICIO TEXT,"
         "SALON TEXT,"
         "FOREIGN KEY (NPROFESOR) REFERENCES PROFESOR(NPROFESOR),"
         "FOREIGN KEY (NMAT) REFERENCES MATERIA(NMAT)"
         ")");
     await db.execute("CREATE TABLE ASISTENCIA("
         "IDASISTENCIA INTEGER PRIMARY KEY AUTOINCREMENT,"
         "NHORARIO INTEGER,"
         "FECHA TEXT,"
         "ASISTIO BOOLEAN,"
         "FOREIGN KEY (NHORARIO) REFERENCES HORARIO(NHORARIO)"
         ")");
     await db.execute("CREATE TABLE PROFESOR("
         "NPROFESOR TEXT PRIMARY KEY,"
         "NOMBRE TEXT,"
         "CARRERA TEXT"
         ")");
  }
}