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

  @override
  void initState(){
    super.initState();
    cargarListas();
  }

  void cargarListas() async{
    List<Profesor> lp = await DBProfesor.consultar();
    List<Materia> lm = await DBMateria.consultar();
    setState(() {
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
    return ListView(
      padding: EdgeInsets.all(50),
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
        SizedBox(height: 15,),
        ElevatedButton(onPressed: (){
          Horario h = Horario(
              NHorario: -1,
              nombre: profesorllaveforanea,
              descripcion: materiallaveforanea,
              hora: hora.text,
              edificio: edificio.text,
              salon: salon.text
          );

          DBHorario.insertar(h).then((value){
            if (value < 1){
              mensaje("ERROR!");
              return;
            }
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