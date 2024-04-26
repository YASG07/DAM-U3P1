import '/controladores/profesorDB.dart';
import '/modelos/profesor.dart';
import 'package:flutter/material.dart';

class agregarProfesores extends StatefulWidget {
  const agregarProfesores({super.key});

  @override
  State<agregarProfesores> createState() => _agregarProfesoresState();
}

class _agregarProfesoresState extends State<agregarProfesores> {
  final nprofesorController = TextEditingController();
  final nombreController = TextEditingController();
  final carreraController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(50),
      children: [
        TextFormField(
          controller: nprofesorController,
          decoration: InputDecoration(
              icon: Icon(Icons.numbers),
              labelText: "Numero de control:"
          ),
        ),
        SizedBox(height: 20,),
        TextFormField(
          controller: nombreController,
          decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: "Nombre:"
          ),
        ),
        SizedBox(height: 30,),
        TextFormField(
          controller: carreraController,
          decoration: InputDecoration(
              icon: Icon(Icons.school),
              labelText: "Carrera:"
          ),
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: (){
                  Profesor p = Profesor(
                      NProfesor: nprofesorController.text,
                      nombre: nombreController.text,
                      carrera: carreraController.text
                  );

                  DBProfesor.insertar(p).then((value){
                    if(value < 1){
                      mensaje("ERROR AL INSERTAR");
                      return;
                    }
                    mensaje("SE HA INSERTADO");
                    setState(() {
                      nprofesorController.clear();
                      nombreController.clear();
                      carreraController.clear();
                    });
                  });
                },
                child: Text("Agregar")),
            SizedBox(width: 15,),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    nprofesorController.clear();
                    nombreController.clear();
                    carreraController.clear();
                  });
                },
                child: Text("Limpiar"))
          ],
        ),
      ],
    );
  }

  void mensaje(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s))
    );
  }
}
