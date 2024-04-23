import 'package:dam_u3_practica1/controladores/horarioDB.dart';
import 'package:dam_u3_practica1/modelos/horario.dart';
import 'package:flutter/material.dart';

class listaHorarios extends StatefulWidget {
  const listaHorarios({super.key});

  @override
  State<listaHorarios> createState() => _listaHorariosState();
}

class _listaHorariosState extends State<listaHorarios> {
  final Hhora = TextEditingController();
  final Hedificio = TextEditingController();
  final Hsalon = TextEditingController();

  List<Horario> listaHorarios = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    cargarHorarios();
  }

  void cargarHorarios() async{
    List<Horario> t = await DBHorario.consultar();
    setState(() {
      listaHorarios = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: listaHorarios.length,
        itemBuilder: (context, index){
          return ListTile(
            // title: Text(listaHorarios[index].hora),
            // subtitle: Text(listaHorarios[index].edificio),
            // trailing: IconButton(onPressed: (){
            //   DBHorario.eliminar(listaHorarios[index].salon);
            //   setState(() {
            //     cargarHorarios();
            //   });
            // }, icon: Icon(Icons.delete)),
            // onTap: (){
            //   Hhora.text = listaHorarios[index].hora;
            //   Hedificio.text = listaHorarios[index].edificio;
            //   Hsalon.text = listaHorarios[index].salon;
            //   ventanaActualizar(index);
            // },
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
                  controller: Hhora,
                  decoration: InputDecoration(
                      labelText: "Hora:"
                  ),
                ),
                SizedBox(height: 30,),
                TextFormField(
                  controller: Hedificio,
                  decoration: InputDecoration(
                      labelText: "Edificio:"
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      Horario h = Horario(
                          NHorario: -1,
                          nombre: "",
                          descripcion: "",
                          hora:Hhora.text ,
                          edificio: Hedificio.text,
                          salon: Hsalon.text
                      );
                      DBHorario.actualizar(h);
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
}
