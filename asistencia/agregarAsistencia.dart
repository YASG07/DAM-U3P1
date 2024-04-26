import '../controladores/asistenciaDB.dart';
import '../controladores/horarioDB.dart';
import '../modelos/asistencia.dart';
import '../modelos/horario.dart';
import 'package:flutter/material.dart';

class agregarAsistencia extends StatefulWidget {
  const agregarAsistencia({super.key});

  @override
  State<agregarAsistencia> createState() => _agregarAsistenciaState();
}

class _agregarAsistenciaState extends State<agregarAsistencia> {

  final fecha = TextEditingController();
  bool asistenciaBox = false;
  List<Horario> listaHorarios = [];
  int horariollaveforanea = 0;

  @override
  void initState(){
    super.initState();
    cargarListas();
  }

  void cargarListas() async{
    List<Horario> lh = await DBHorario.consultar();
    setState(() {
      listaHorarios = lh;
      if (lh.isNotEmpty) {
        horariollaveforanea = lh.first.NHorario;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(50),
      children: [
        DropdownButtonFormField(
          value: horariollaveforanea,
          items: listaHorarios.map((e){
            return DropdownMenuItem(
                value: e.NHorario,
                child: Text("${e.hora} - ${e.nombre}")
            );
          }).toList(),
          onChanged: (valorID){
            setState(() {
              horariollaveforanea = valorID!;
            });
          },
          decoration: InputDecoration(
              labelText: "Horario",
              icon: Icon(Icons.access_alarm)
          ),
        ),
        SizedBox(height: 15,),
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
        ElevatedButton(onPressed: (){
          Asistencia a = Asistencia(
              idAsistencia: -1, 
              NHorario: horariollaveforanea, 
              fecha: fecha.text, 
              asistio: asistenciaBox
          );

          DBAsistencia.insertar(a).then((value){
            if (value < 1){
              mensaje("ERROR!");
              return;
            }
            mensaje("SE INSERTO");
            setState(() {
              fecha.clear();
              asistenciaBox = false;
            });
          });
        }, child: Text("Capturar"))
      ],
    );
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

  void mensaje(String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }
}
