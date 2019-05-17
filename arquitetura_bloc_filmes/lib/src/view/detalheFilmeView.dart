import 'package:arquitetura_bloc_filmes/src/blocs/filmeDetalheBloc.dart';
import 'package:arquitetura_bloc_filmes/src/blocs/filmeDetalheBlocProvider.dart';
import 'package:arquitetura_bloc_filmes/src/models/trailerModel.dart';
import 'package:flutter/material.dart';

class DetalheFilmeView extends StatefulWidget {
  final posterUrl;
  final descricao;
  final dataLancamento;
  final String titulo;
  final String mediaVoto;
  final int filmeId;

  DetalheFilmeView({
    this.titulo,
    this.posterUrl,
    this.descricao,
    this.dataLancamento,
    this.mediaVoto,
    this.filmeId,
  });

  @override
  State<StatefulWidget> createState() {
    return DetalheFilmeViewState(
      titulo: titulo,
      posterUrl: posterUrl,
      descricao: descricao,
      dataLancamento: dataLancamento,
      mediaVoto: mediaVoto,
      filmeId: filmeId,
    );
  }
}

class DetalheFilmeViewState extends State<DetalheFilmeView> {
  final posterUrl;
  final descricao;
  final dataLancamento;
  final String titulo;
  final String mediaVoto;
  final int filmeId;

  FilmeDetalheBloc filmeDetalheBloc;

  DetalheFilmeViewState({
    this.titulo,
    this.posterUrl,
    this.descricao,
    this.dataLancamento,
    this.mediaVoto,
    this.filmeId,
  });

  @override
  void didChangeDependencies() {
    filmeDetalheBloc = FilmeDetalheBlocProvider.of(context);
    filmeDetalheBloc.carregarTrailersPorId(filmeId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    filmeDetalheBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  "https://image.tmdb.org/t/p/w500$posterUrl",
                  fit: BoxFit.cover,
                )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 5.0)),
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                    Text(
                      mediaVoto,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    Text(
                      dataLancamento,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(descricao),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(
                  "Trailer",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                StreamBuilder(
                  stream: filmeDetalheBloc.trailersStream,
                  builder:
                      (context, AsyncSnapshot<Future<TrailerModel>> snapshot) {
                    if (snapshot.hasData) {
                      return FutureBuilder(
                        future: snapshot.data,
                        builder: (context,
                            AsyncSnapshot<TrailerModel> itemSnapShot) {
                          if (itemSnapShot.hasData) {
                            if (itemSnapShot.data.results.length > 0)
                              return trailerLayout(itemSnapShot.data);
                            else
                              return noTrailer(itemSnapShot.data);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noTrailer(TrailerModel data) {
    return Center(
      child: Container(
        child: Text("Não existem trailers disponíveis"),
      ),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    if (data.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel data, int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 100.0,
            color: Colors.black,
            child: Center(child: Icon(Icons.play_circle_filled)),
          ),
          Text(
            data.results[index].nome,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
