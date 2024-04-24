import 'package:dam_u3_practica1/controladores/asistenciaDB.dart';
import 'package:flutter/material.dart';

import '../modelos/asistenciaHorario.dart';

class listarAsistencias extends StatefulWidget {
  const listarAsistencias({super.key});

  @override
  State<listarAsistencias> createState() => _listarAsistenciasState();
}

class _listarAsistenciasState extends State<listarAsistencias> {
  List<AsistenciaHorario> listaAsistencia = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarAsistencias();
  }

  void cargarAsistencias() async{
    List<AsistenciaHorario> la = await DBAsistencia.consultar();
    setState(() {
      listaAsistencia = la;
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
            subtitle: Text(listaAsistencia[index].fecha),
            leading: Text("${listaAsistencia[index].asistio}"),
            trailing: IconButton(
                onPressed: (){

                }, icon: Icon(Icons.delete)),
            onTap: (){

            },
          );
        });
  }
}
