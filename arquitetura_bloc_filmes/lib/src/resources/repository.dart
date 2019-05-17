import 'dart:async';
import 'filmesService.dart';
import '../models/item_model.dart';

class Repository {
  final filmesService = FilmesService();

  Future<ItemModel> carregarTodosFilmes() => filmesService.carregaFilmes();
}