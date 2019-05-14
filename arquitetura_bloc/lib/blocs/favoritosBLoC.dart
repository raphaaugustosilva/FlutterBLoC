import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:arquitetura_bloc/model/video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class FavoritosBLoC implements BlocBase {
  Map<String, Video> _favoritos = {};

  final _favoritosController = BehaviorSubject<Map<String, Video>>.seeded({});

  Stream<Map<String, Video>> get outFavoritosStream =>
      _favoritosController.stream;

  FavoritosBLoC() {
    SharedPreferences.getInstance().then((preferencias) {
      if (preferencias.getKeys().contains("favoritos")) {
        _favoritos =
            json.decode(preferencias.getString("favoritos")).map((key, value) {
          return MapEntry(key, Video.fromJson(value));
        }).cast<String, Video>();

        _favoritosController.add(_favoritos);
      }
    });
  }

  void marcaFavorito(Video video) {
    if (_favoritos.containsKey(video.id))
      _favoritos.remove(video.id);
    else
      _favoritos[video.id] = video;

    _favoritosController.sink.add(_favoritos);

    _salvarFavorito();
  }

  void _salvarFavorito() {
    SharedPreferences.getInstance().then((preferencias) {
      preferencias.setString("favoritos", json.encode(_favoritos));
    });
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _favoritosController.close();
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
