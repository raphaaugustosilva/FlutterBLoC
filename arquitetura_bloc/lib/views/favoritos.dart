import 'package:arquitetura_bloc/blocs/favoritosBLoC.dart';
import 'package:arquitetura_bloc/helpers/configuracoes.dart';
import 'package:arquitetura_bloc/model/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Favoritos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritosBLoC = BlocProvider.getBloc<FavoritosBLoC>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: favoritosBLoC.outFavoritosStream,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((video) {
              return InkWell(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                    apiKey: GOOGLE_API_KEY,
                    videoId:video.id 
                  );
                },
                onLongPress: () {
                  favoritosBLoC.marcaFavorito(video);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(video.thumbnail),
                    ),
                    Expanded(
                      child: Text(
                        video.titulo,
                        style: TextStyle(color: Colors.white70),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
