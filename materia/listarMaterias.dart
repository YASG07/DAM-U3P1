import 'package:dam_u3_practica1/controladores/materiaDB.dart';
import 'package:dam_u3_practica1/modelos/materia.dart';
import 'package:flutter/material.dart';

class listarMaterias extends StatefulWidget {
  const listarMaterias({super.key});

  @override
  State<listarMaterias> createState() => _listarMateriasState();
}

class _listarMateriasState extends State<listarMaterias> {
  final nmatController = TextEditingController();
  final descripcionController = TextEditingController();

  List<Materia> listaMaterias = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarMaterias();
  }

  void cargarMaterias() async{
    List<Materia> t = await DBMateria.consultar();
    setState(() {
      listaMaterias = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: listaMaterias.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(listaMaterias[index].NMat),
          subtitle: Text(listaMaterias[index].descripcion),
          trailing: IconButton(onPressed: (){
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
                    content: Text("Estas seguro que deseas eliminar este elemento (${listaMaterias[index].NMat} - ${listaMaterias[index].descripcion})",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: (){
                            DBMateria.eliminar(listaMaterias[index].NMat);
                            setState(() {
                              cargarMaterias();
                            });
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
          }, icon: Icon(Icons.delete)),
          onTap: (){
            nmatController.text = listaMaterias[index].NMat;
            descripcionController.text = listaMaterias[index].descripcion;
            ventanaActualizar(index);
          },
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
                TextField(
                  controller: descripcionController,
                  decoration: InputDecoration(labelText: 'Nueva descripción:'),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      Materia m = Materia(
                          NMat: nmatController.text,
                          descripcion: descripcionController.text
                      );

                      DBMateria.actualizar(m);

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
}
