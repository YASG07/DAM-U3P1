import 'package:dam_u3_practica1/controladores/asistenciaDB.dart';
import 'package:flutter/material.dart';
import '../modelos/asistenciaHorario.dart';

class BusquedaProfesor extends SearchDelegate{

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.lightBlueAccent,
      )
    );
  }//modifica el appbar

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(onPressed: (){
      query = '';
    }, icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){
      close(context, null);//lo mismo que Navigator.pop();
    }, icon: Icon(Icons.arrow_back_sharp));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder(
        future: DBAsistencia.consultarPorProfresor(query),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return _coincidencias(snapshot.data);
          } else {
            return const Center(
                child: Text('No hubo coincidencias',
                style: TextStyle(fontSize: 20, color: Colors.red),)
            );
          }
        },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return const Center(
      child: Text('Escriba el nombre del docente',
      style: TextStyle(fontSize: 18),));
  }

  Widget _coincidencias(List<AsistenciaHorario> listData) {
      return ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: listData.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(listData[index].nombre),
              subtitle: Text("${listData[index].fecha} ${listData[index].hora}"),
              leading: CircleAvatar(
                backgroundColor: listData[index].asistio == 1 ? Colors.greenAccent : Colors.redAccent,
                child: Icon(listData[index].asistio == 1 ? Icons.check : Icons.clear),
              ),
              trailing: IconButton(
                  onPressed: (){

                  }, icon: Icon(Icons.delete)),
              onTap: (){

              },
            );
          },
      );
  }
  
}