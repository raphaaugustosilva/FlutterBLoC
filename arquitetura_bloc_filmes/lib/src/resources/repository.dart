import 'dart:async';
import 'package:arquitetura_bloc_filmes/src/models/trailerModel.dart';

import 'filmesService.dart';
import '../models/itemModel.dart';

class Repository {
  final filmesService = FilmesService();

  Future<ItemModel> carregarTodosFilmes() => filmesService.carregaFilmes();
  Future<TrailerModel> carregarTrailers(int filmeId) => filmesService.carregaTrailers(filmeId);
}