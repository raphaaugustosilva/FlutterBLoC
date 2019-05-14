import 'package:arquitetura_bloc/blocs/favoritosBLoC.dart';
import 'package:arquitetura_bloc/blocs/videosBLoC.dart';
import 'package:arquitetura_bloc/delegates/pesquisaVideoSearchDelegate.dart';
import 'package:arquitetura_bloc/model/video.dart';
import 'package:arquitetura_bloc/views/favoritos.dart';
import 'package:arquitetura_bloc/views/widgets/videoTile.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videosBLoC = BlocProvider.getBloc<VideosBLoC>();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("imagens/yt_logo_rgb_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.getBloc<FavoritosBLoC>().outFavoritosStream,
              initialData: {},
              builder: (context, snapshot) {
                if (snapshot.hasData) return Text("${snapshot.data.length}");
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Favoritos()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String resultado = await showSearch(
                  context: context, delegate: PesquisaVideoSearchDelegate());
              if (resultado != null) videosBLoC.inPesquisaSink.add(resultado);
            },
          )
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: videosBLoC.outVideosStream,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  videosBLoC.inPesquisaSink.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                } else
                  return Container();
              },
              itemCount: snapshot.data.length + 1,
            );
          else
            return Container();
        },
      ),
    );
  }
}
