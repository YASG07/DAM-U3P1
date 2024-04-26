import '../controladores/asistenciaDB.dart';
import 'package:flutter/material.dart';

import '../modelos/asistenciaHorario.dart';

class BusquedaAsistencia extends SearchDelegate{

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
    }, icon: Icon(Icons.clear)),
    IconButton(onPressed: (){
      String today = DateTime.now().toString();
      List d = today.split(' ');
      query = d[0];
    }, icon: Icon(Icons.today))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder(
        future: DBAsistencia.consultarPorFecha(query),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return _coincidencias(snapshot.data);
          } else {
            return const Center(
                child: Text('No hubo coincidencias',
                  style: TextStyle(fontSize: 20, color: Colors.red),)
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return const Center(
        child: Text('Escribe la fecha en AAAA-MM-DD',
          style: TextStyle(fontSize: 18),));
  }

  Widget _coincidencias(List<AsistenciaHorario> listData) {
    return ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: listData.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(listData[index].fecha),
            subtitle: Text("${listData[index].nombre} \nDe ${listData[index].hora}"),
            leading: CircleAvatar(
              backgroundColor: listData[index].asistio == 1 ? Colors.greenAccent : Colors.red,
              child: listData[index].asistio == 1 ? Icon(Icons.check) : Icon(Icons.clear),
            ),
          );
        });
  }

}