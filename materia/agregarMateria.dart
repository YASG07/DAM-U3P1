import '/controladores/materiaDB.dart';
import '/modelos/materia.dart';
import 'package:flutter/material.dart';

class agregarMaterias extends StatefulWidget {
  const agregarMaterias({super.key});

  @override
  State<agregarMaterias> createState() => _agregarMateriasState();
}

class _agregarMateriasState extends State<agregarMaterias> {
  final nmatController = TextEditingController();
  final descripcionController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(50),
      children: [
        TextFormField(
          controller: nmatController,
          decoration: InputDecoration(
            icon: Icon(Icons.book),
            labelText: "Nombre:"
          ),
        ),
        SizedBox(height: 20,),
        TextFormField(
          controller: descripcionController,
          decoration: InputDecoration(
              icon: Icon(Icons.description),
              labelText: "Descripción:"
          ),
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: (){
                  Materia m = Materia(
                      NMat: nmatController.text,
                      descripcion: descripcionController.text
                  );
                  DBMateria.insertar(m).then((value){
                    if(value < 1){
                      mensaje("ERROR AL INSERTAR");
                      return;
                    }
                    mensaje("SE HA INSERTADO");
                    setState(() {
                      nmatController.clear();
                      descripcionController.clear();
                    });
                  });
                },
                child: Text("Agregar")),
            SizedBox(width: 15,),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    nmatController.clear();
                    descripcionController.clear();
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
