import 'package:flutter/material.dart';
import 'dart:convert';
import 'configuracoes.dart';
import 'package:http/http.dart' as http;
import 'package:arquitetura_bloc/model/video.dart';

class ApiHelper {
  String _pesquisa;
  String _proximaPaginaToken;

  Future<List<Video>> pesquisar(String pesquisa) async {
    _pesquisa = pesquisa;
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$pesquisa&type=video&key=$GOOGLE_API_KEY&maxResults=10");

    return deserializarERetornarVideos(response);
  }

  Future<List<Video>> proximaPagina() async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_pesquisa&type=video&key=$GOOGLE_API_KEY&maxResults=10&pageToken=$_proximaPaginaToken");

    return deserializarERetornarVideos(response);
  }

  List<Video> deserializarERetornarVideos(http.Response response) {
    if (response.statusCode == 200) {
      var resultadoDeserializado = json.decode(response.body);

      _proximaPaginaToken = resultadoDeserializado["nextPageToken"];

      List<Video> videos = resultadoDeserializado["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;
    } else {
      throw Exception("Erro ao carregar vídeos");
    }
  }
}
