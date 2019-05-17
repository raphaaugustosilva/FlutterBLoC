import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/filmesBloc.dart';

class ListagemFilmes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    filmesBLoC.carregarTodosFilmes();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes populares'),
      ),
      body: StreamBuilder(
        stream: filmesBLoC.todosFilmesStream,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.resultados.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            'https://image.tmdb.org/t/p/w185${snapshot.data
                .resultados[index].posterPath}',
            fit: BoxFit.cover,
          );
        });
  }
}
