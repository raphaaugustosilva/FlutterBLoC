import 'dart:async';
import 'package:arquitetura_bloc/model/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:arquitetura_bloc/helpers/apiHelper.dart';

class VideosBLoC implements BlocBase {
  ApiHelper apiHelper;
  List<Video> videos;

  final StreamController<List<Video>> _videosController =
      StreamController<List<Video>>();
  Stream get outVideosStream => _videosController.stream;

  final StreamController<String> _pesquisaController =
      StreamController<String>();
  Sink get inPesquisaSink => _pesquisaController.sink;

  VideosBLoC() {
    apiHelper = ApiHelper();

    _pesquisaController.stream.listen(_pesquisar);
  }

  void _pesquisar(String pesquisa) async {
    if (pesquisa != null) {
      _videosController.sink.add([]);
      videos = await apiHelper.pesquisar(pesquisa);
    }
    else {
      videos += await apiHelper.proximaPagina();
    }
    _videosController.sink.add(videos);
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _videosController.close();
    _pesquisaController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
}
