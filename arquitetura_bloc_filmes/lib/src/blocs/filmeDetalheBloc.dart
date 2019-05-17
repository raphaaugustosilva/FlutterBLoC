
import 'dart:async';
import 'package:arquitetura_bloc_filmes/src/models/trailerModel.dart';
import 'package:rxdart/rxdart.dart';
import '../models/trailerModel.dart';
import '../resources/repository.dart';

class FilmeDetalheBloc {
  final _repository = Repository();
  final _filmeId = PublishSubject<int>();
  final _trailers = BehaviorSubject<Future<TrailerModel>>();

  Observable<Future<TrailerModel>> get trailersStream => _trailers.stream;
  Function(int) get carregarTrailersPorId => _filmeId.sink.add;

  FilmeDetalheBloc() {
    _filmeId.stream.transform(_transformaTrailer()).pipe(_trailers);
  }

  dispose() async {
    _filmeId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _transformaTrailer() {
    return ScanStreamTransformer(
      (Future<TrailerModel> trailer, int id, int index) {
        print(index);
        trailer = _repository.carregarTrailers(id);
        return trailer;
      },
    );
  }
}