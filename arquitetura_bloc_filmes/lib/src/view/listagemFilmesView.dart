import 'package:arquitetura_bloc_filmes/src/blocs/filmeDetalheBlocProvider.dart';
import 'package:arquitetura_bloc_filmes/src/view/detalheFilmeView.dart';
import 'package:flutter/material.dart';
import '../models/itemModel.dart';
import '../blocs/filmesBloc.dart';

class ListagemFilmesView extends StatefulWidget {
  @override
  _ListagemFilmesViewState createState() => _ListagemFilmesViewState();
}

class _ListagemFilmesViewState extends State<ListagemFilmesView> {
  @override
  void initState() {
    super.initState();
    filmesBLoC.carregarTodosFilmes();
  }

  @override
  void dispose() {
    filmesBLoC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data.resultados[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () => navegaParaDetalheFilme(snapshot.data, index),
            ),
          );
        });
  }

  navegaParaDetalheFilme(ItemModel data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // return DetalheFilme(
          //   titulo: data.resultados[index].titulo,
          //   posterUrl: data.resultados[index].backdropPath,
          //   descricao: data.resultados[index].overview,
          //   dataLancamento: data.resultados[index].dataLancamento,
          //   mediaVoto: data.resultados[index].votosMedia.toString(),
          //   filmeId: data.resultados[index].id,
          // );

          return FilmeDetalheBlocProvider(
            child: DetalheFilmeView(
              titulo: data.resultados[index].titulo,
              posterUrl: data.resultados[index].backdropPath,
              descricao: data.resultados[index].overview,
              dataLancamento: data.resultados[index].dataLancamento,
              mediaVoto: data.resultados[index].votosMedia.toString(),
              filmeId: data.resultados[index].id,
            ),
          );
        },
      ),
    );
  }
}
