import 'package:dam_u3_practica1/controladores/horarioDB.dart';
import 'package:flutter/material.dart';
import '../modelos/horario.dart';

class BusquedaMateria extends SearchDelegate{

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
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder(
        future: DBHorario.consultarPorMateria(query),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return _resultados(snapshot.data);
          } else {
            return const Center(
                child: Text('No hubo coincidencias',
                style: TextStyle(fontSize: 20, color: Colors.red),)
            );
          }
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return const Center(
        child: Text('Escriba el nombre de la materia',
          style: TextStyle(fontSize: 18),));
  }

  Widget _resultados(List<Horario> listData) {
    return ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: listData.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text("${listData[index].descripcion}: ${listData[index].nombre}"),
            subtitle: Text("${listData[index].edificio} - ${listData[index].salon}"),
            leading:  Text(listData[index].hora),
            trailing: IconButton(
                onPressed: (){

                }, icon: Icon(Icons.delete)),
            onTap: (){

            },
          );
        }
    );
  }

}