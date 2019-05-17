import 'dart:async';
import 'package:arquitetura_bloc_filmes/src/models/trailerModel.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/itemModel.dart';

class FilmesService {
  Client httpClient = Client();
  final _apiKey = "be24ff102e74a60d745e5b6c9a5fe41a";
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<ItemModel> carregaFilmes() async {
    final response = await httpClient.get("$_baseUrl/popular?api_key=$_apiKey");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Erro ao carregar post');
    }
  }

  Future<TrailerModel> carregaTrailers(int filmeId) async {
    final response =
        await httpClient.get("$_baseUrl/$filmeId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao carregar trailers!');
    }
  }
}
