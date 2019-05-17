import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class FilmesBloc {
  final _repository = Repository();
  final _filmesSubject = PublishSubject<ItemModel>();

  Observable<ItemModel> get todosFilmesStream => _filmesSubject.stream;

  carregarTodosFilmes() async {
    ItemModel itemModel = await _repository.carregarTodosFilmes();

    _filmesSubject.sink.add(itemModel);
  }

  dispose() {
    _filmesSubject.close();
  }
}

final filmesBLoC = FilmesBloc();
