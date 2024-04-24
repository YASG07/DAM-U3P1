import 'package:dam_u3_practica1/asistencia/agregarAsistencia.dart';
import 'package:dam_u3_practica1/asistencia/listarAsistencias.dart';
import 'package:dam_u3_practica1/horario/listarHorario.dart';
import 'package:dam_u3_practica1/materia/agregarMateria.dart';
import 'package:dam_u3_practica1/horario/agregarHorario.dart';
import 'package:dam_u3_practica1/materia/listarMaterias.dart';
import 'package:dam_u3_practica1/profesor/agregarProfesor.dart';
import 'package:dam_u3_practica1/profesor/listarProfesor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Asistencia en el aula"),
            backgroundColor: Colors.blue,
            centerTitle: true,
            bottom: TabBar(
                labelStyle: TextStyle(
                    color: Colors.white
                ),
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: "Agregar", icon: Icon(Icons.add),),
                  Tab(text: "Listado", icon: Icon(Icons.list),)
                ]
            ),
          ),
          body: dinamico(),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person, size: 35,),
                      radius: 35,
                    ),
                    Text("Control"),
                    Text("(c) Moviles 2024",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                      ),
                    )
                  ],
                ),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent
                  ),
                ),
                SizedBox(height: 40,),
                itemDrawer(1, Icons.library_add_check, "Asistencias"),
                itemDrawer(2, Icons.book, "Materias"),
                itemDrawer(3, Icons.person, "Profesores"),
                itemDrawer(4, Icons.access_time_filled, "Horarios"),
              ],
            ),
          ),
        )
    );
  }

 Widget itemDrawer(int indice, IconData icon, String texto) {
    return ListTile(
         onTap: (){
           setState(() {
             _index = indice;
           });
           Navigator.pop(context);
         },
         title: Row(
           children: [
             Expanded(child: Icon(icon)),
             Expanded(child: Text(texto), flex: 2,)
           ],
         ),
       );
    }

  Widget dinamico() {
    switch(_index){
      case 1: return TabBarView(children: [agregarAsistencia(), listarAsistencias()]);
      case 2: return TabBarView(children: [agregarMaterias(), listarMaterias()]);
      case 3: return TabBarView(children: [agregarProfesores(), listarProfesores()]);
      case 4: return TabBarView(children: [agregarHorarios(), listaHorarios()]);
      default: return const Center(
          child: Text('Por favor! Seleccione una opción del menú lateral.',
          style: TextStyle(fontSize: 16,),));
    }
  }
}