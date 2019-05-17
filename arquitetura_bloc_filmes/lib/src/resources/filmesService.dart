import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class FilmesService {
  Client httpClient = Client();
  final _apiKey = "be24ff102e74a60d745e5b6c9a5fe41a";

  Future<ItemModel> carregaFilmes() async {
    final response = await httpClient
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Erro ao carregar post');
    }
  }
}