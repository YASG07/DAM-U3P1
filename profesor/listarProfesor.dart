import '/controladores/profesorDB.dart';
import '/modelos/profesor.dart';
import 'package:flutter/material.dart';

class listarProfesores extends StatefulWidget {
  const listarProfesores({super.key});

  @override
  State<listarProfesores> createState() => _listarProfesoresState();
}

class _listarProfesoresState extends State<listarProfesores> {
  final nprofesorController = TextEditingController();
  final nombreController = TextEditingController();
  final carreraController = TextEditingController();

  List<Profesor> listaProfesores = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarMaterias();
  }

  void cargarMaterias() async{
    List<Profesor> t = await DBProfesor.consultar();
    setState(() {
      listaProfesores = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: listaProfesores.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(listaProfesores[index].nombre),
            subtitle: Text(listaProfesores[index].carrera),
            trailing: IconButton(onPressed: (){
              botonEliminar(index);
            }, icon: Icon(Icons.delete)),
            onTap: (){
              nprofesorController.text = listaProfesores[index].NProfesor;
              nombreController.text = listaProfesores[index].nombre;
              carreraController.text = listaProfesores[index].carrera;
             ventanaActualizar(index);
            },
          );
        }
    );
  }

  void botonEliminar(int index){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            icon: Icon(
              Icons.warning,
              color: Colors.white,
            ),
            backgroundColor: Colors.redAccent,
            title: Text("Cuidado!",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            content: Text("Estas seguro que deseas eliminar este elemento (${listaProfesores[index].nombre} - ${listaProfesores[index].carrera})",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    DBProfesor.eliminar(listaProfesores[index].NProfesor);
                    setState(() {
                      cargarMaterias();
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Eliminar",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              )
            ],
          );
        }
    );
  }

  void ventanaActualizar(int index) {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (builder){
          return Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 40,
              right: 40,
              bottom: MediaQuery.of(context).viewInsets.bottom+300,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nombreController,
                  decoration: InputDecoration(
                      labelText: "Nombre:"
                  ),
                ),
                SizedBox(height: 30,),
                TextFormField(
                  controller: carreraController,
                  decoration: InputDecoration(
                      labelText: "Carrera:"
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      Profesor p = Profesor(
                          NProfesor: nprofesorController.text,
                          nombre: nombreController.text,
                          carrera: carreraController.text
                      );

                      DBProfesor.actualizar(p);
                      setState(() {
                        cargarMaterias();
                      });
                      Navigator.pop(context);
                    }, child: const Text('Actualizar')),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text('Cancelar')),
                  ],
                ),
              ],
            ),
          );
        });
  }//ventana modal

  void mensaje(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s))
    );
  }
}
