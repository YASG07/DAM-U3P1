import 'package:dam_u3_practica1/controladores/asistenciaDB.dart';
import 'package:dam_u3_practica1/controladores/horarioDB.dart';
import 'package:dam_u3_practica1/horario/listarHorario.dart';
import 'package:flutter/material.dart';

import '../modelos/asistencia.dart';
import '../modelos/asistenciaHorario.dart';
import '../modelos/horario.dart';

class listarAsistencias extends StatefulWidget {
  const listarAsistencias({super.key});

  @override
  State<listarAsistencias> createState() => _listarAsistenciasState();
}

class _listarAsistenciasState extends State<listarAsistencias> {

  List<AsistenciaHorario> listaAsistencia = [];
  final fecha = TextEditingController();
  bool asistenciaBox = false;
  List<Horario> listaHorarios = [];
  int horariollaveforanea = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarAsistencias();
  }

  void cargarAsistencias() async{
    List<AsistenciaHorario> la = await DBAsistencia.consultar();
    List<Horario> lh = await DBHorario.consultar();
    setState(() {
      listaAsistencia = la;
      listaHorarios = lh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: listaAsistencia.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${listaAsistencia[index].hora} : ${listaAsistencia[index].nombre}"),
            subtitle: Text("${listaAsistencia[index].fecha} - ${listaAsistencia[index].idAsistencia}"),
            leading: leadingAsistencia(listaAsistencia[index].asistio),
            trailing: IconButton(
                onPressed: (){
                  botonEliminar(index);
                }, icon: Icon(Icons.delete)),
            onTap: (){
              asistenciaBox = modalActualizarCheck(listaAsistencia[index].asistio);
              fecha.text = listaAsistencia[index].fecha;
              ventanaActualizar(index, listaAsistencia[index].idAsistencia);
            },
          );
        });
  }

  bool modalActualizarCheck(int a){
    return a == 1;
  }

  Widget leadingAsistencia(int a) {
    return CircleAvatar(
      backgroundColor: a == 1 ? Colors.greenAccent : Colors.redAccent,
      child: Icon(a == 1 ? Icons.check : Icons.clear),
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
            content: Text("Estas seguro que deseas eliminar este elemento (${listaAsistencia[index].nombre} - ${listaAsistencia[index].hora} - ${listaAsistencia[index].fecha})",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    DBAsistencia.eliminar(listaAsistencia[index].idAsistencia);
                    setState(() {
                      cargarAsistencias();
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
                TextField(
                  controller: fecha,
                  decoration: InputDecoration(
                      labelText: 'Fecha:',
                      icon: Icon(Icons.date_range)
                  ),
                  readOnly: true,
                  onTap: (){
                    selecionarFecha();
                  },
                ),
                SizedBox(height: 15,),
                CheckboxListTile(
                    title: Text("Asistencia"),
                    value: asistenciaBox,
                    onChanged: (data){
                      setState(() {
                        asistenciaBox = data!;
                      });
                    }),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      Asistencia a = Asistencia(
                          idAsistencia: -1,
                          NHorario: horariollaveforanea,
                          fecha: fecha.text,
                          asistio: asistenciaBox
                      );

                      DBAsistencia.actualizar(a,idactualizar);
                      setState(() {
                        cargarAsistencias();
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
  }

  Future<void> selecionarFecha() async{
    DateTime? fechaSelecionada = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );

    if (fechaSelecionada != null){
      setState(() {
        fecha.text = fechaSelecionada.toString().split(" ")[0];
      });
    }
  }
}
