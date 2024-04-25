import 'package:dam_u3_practica1/controladores/horarioDB.dart';
import 'package:dam_u3_practica1/modelos/horario.dart';
import 'package:flutter/material.dart';
import '../controladores/materiaDB.dart';
import '../controladores/profesorDB.dart';
import '../modelos/materia.dart';
import '../modelos/profesor.dart';

class listaHorarios extends StatefulWidget {
  const listaHorarios({super.key});

  @override
  State<listaHorarios> createState() => _listaHorariosState();
}

class _listaHorariosState extends State<listaHorarios> {
  final hora = TextEditingController();
  final edificio = TextEditingController();
  final salon = TextEditingController();

  List<Profesor> listaProfesor = [];
  List<Materia> listaMateria = [];
  List<Horario> listaHorarios = [];

  String profesorllaveforanea = '';
  String materiallaveforanea = '';

  void initState() {
    // TODO: implement initState
    super.initState();
    cargarHorarios();
  }

  void cargarHorarios() async{
    List<Horario> t = await DBHorario.consultar();
    List<Profesor> lp = await DBProfesor.consultar();
    List<Materia> lm = await DBMateria.consultar();
    setState(() {
      listaHorarios = t;
      listaProfesor = lp;
      listaMateria = lm;
      if (lp.isNotEmpty) {
        profesorllaveforanea = lp.first.NProfesor;
      }
      if (lm.isNotEmpty) {
        materiallaveforanea = lm.first.NMat;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: listaHorarios.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text("${listaHorarios[index].nombre} - ${listaHorarios[index].descripcion}"),
            subtitle: Text("${listaHorarios[index].edificio} - ${listaHorarios[index].salon}"),
            leading: Text(listaHorarios[index].hora),
            trailing: IconButton(onPressed: (){
              botonEliminar(index);
            }, icon: Icon(Icons.delete)),
            onTap: (){
              profesorllaveforanea = encontrarProfesor(listaHorarios[index].nombre);
              materiallaveforanea = encontrarMateria(listaHorarios[index].descripcion);
              hora.text = listaHorarios[index].hora;
              edificio.text = listaHorarios[index].edificio;
              salon.text = listaHorarios[index].salon;
              ventanaActualizar(index, listaHorarios[index].NHorario);
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
            content: Text("Estas seguro que deseas eliminar este elemento (${listaHorarios[index].nombre} - ${listaHorarios[index].descripcion} - ${listaHorarios[index].hora})",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    DBHorario.eliminar(listaHorarios[index].NHorario);
                    setState(() {
                      cargarHorarios();
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

  void ventanaActualizar(int index, int idactualizar) {
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
              bottom: MediaQuery.of(context).viewInsets.bottom+250,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  value: profesorllaveforanea,
                  items: listaProfesor.map((e){
                    return DropdownMenuItem(
                        value: e.NProfesor,
                        child: Text(e.nombre)
                    );
                  }).toList(),
                  onChanged: (valorID){
                    setState(() {
                      profesorllaveforanea = valorID!;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Profesor",
                      icon: Icon(Icons.person)
                  ),
                ),
                SizedBox(height: 15,),
                DropdownButtonFormField(
                  value: materiallaveforanea,
                  items: listaMateria.map((e){
                    return DropdownMenuItem(
                        value: e.NMat,
                        child: Text(e.descripcion)
                    );
                  }).toList(),
                  onChanged: (valorID){
                    setState(() {
                      materiallaveforanea = valorID.toString();
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Materia:",
                      icon: Icon(Icons.book)
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: hora,
                  decoration: InputDecoration(
                      labelText: 'Hora:',
                      icon: Icon(Icons.access_time_filled)
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: edificio,
                  decoration: InputDecoration(
                      labelText: 'Edificio:',
                      icon: Icon(Icons.factory)
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: salon,
                  decoration: InputDecoration(
                      labelText: 'Salon:',
                      icon: Icon(Icons.school)
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      Horario h = Horario(
                          NHorario: -1,
                          nombre: profesorllaveforanea,
                          descripcion: materiallaveforanea,
                          hora: hora.text,
                          edificio: edificio.text,
                          salon: salon.text
                      );
                      DBHorario.actualizar(h, idactualizar);
                      setState(() {
                        cargarHorarios();
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

  String encontrarProfesor(String buscar){
    for (var profesor in listaProfesor) {
      if (buscar == profesor.nombre) {
        return profesor.NProfesor;
      }
    }
    return listaProfesor.first.NProfesor;
  }

  String encontrarMateria(String buscar){
    for (var materia in listaMateria) {
      if (buscar == materia.descripcion) {
        return materia.NMat;
      }
    }

    return listaMateria.first.NMat;
  }
}
