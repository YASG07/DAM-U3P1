import 'package:dam_u3_practica1/controladores/horarioDB.dart';
import 'package:dam_u3_practica1/controladores/materiaDB.dart';
import 'package:dam_u3_practica1/controladores/profesorDB.dart';
import 'package:flutter/material.dart';
import 'package:dam_u3_practica1/modelos/profesor.dart';
import 'package:dam_u3_practica1/modelos/materia.dart';
import 'package:dam_u3_practica1/modelos/horario.dart';

class agregarHorarios extends StatefulWidget {
  const agregarHorarios({super.key});

  @override

  State<agregarHorarios> createState() => _agregarHorariosState();
}

class _agregarHorariosState extends State<agregarHorarios> {
  final hora = TextEditingController();
  final edificio = TextEditingController();
  final salon = TextEditingController();
  List<Profesor> listaProfesor = [];
  List<Materia> listaMateria = [];
  String profesorllaveforanea = '';
  String materiallaveforanea = '';

  void iniState(){
    super.initState();
    cargarListas();
  }

  void cargarListas() async{
    List<Profesor> la = await DBProfesor.consultar();
    List<Materia> lac = await DBMateria.consultar();
    setState(() {
      listaProfesor = la;
      listaMateria = lac;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(50),
      children: [
        DropdownButtonFormField(
            items: listaProfesor.map((e){
              return DropdownMenuItem(
                value: e.NProfesor,
                child: Text(e.nombre));
            }).toList(),
            onChanged: (valorID){
              setState(() {
                profesorllaveforanea = valorID!;
              });
            }
        ),
        SizedBox(height: 15,),
        DropdownButtonFormField(
            items: listaMateria.map((e){
              return DropdownMenuItem(
                value: e.NMat,
                child: Text(e.descripcion));
            }).toList(),
            onChanged: (valorID){
              setState(() {
                profesorllaveforanea = valorID!;
              });
            }
        ),
        SizedBox(height: 15,),
        TextField(
          controller: hora,
          decoration: InputDecoration(labelText: 'HORA:'),
        ),
        SizedBox(height: 15,),
        TextField(
          controller: edificio,
          decoration: InputDecoration(labelText: 'EDIFICIO:'),
        ),
        SizedBox(height: 15,),
        TextField(
          controller: salon,
          decoration: InputDecoration(labelText: 'SALON:'),
        ),
        SizedBox(height: 15,),
        ElevatedButton(onPressed: (){
          Horario h = Horario(
              NHorario: -1,
              nombre: profesorllaveforanea,
              descripcion: materiallaveforanea,
              hora: hora.text,
              edificio: edificio.text,
              salon: salon.text);
          DBHorario.insertar(h).then((value){
            mensaje("SE INSERTO");
            hora.clear();
            edificio.clear();
            salon.clear();
          });

        }, child: Text("Capturar"))
      ],
    );
  }

  void mensaje(String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }

}