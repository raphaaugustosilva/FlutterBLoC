import 'package:flutter/material.dart';
import 'filmeDetalheBloc.dart';
export 'filmeDetalheBloc.dart';

class FilmeDetalheBlocProvider extends InheritedWidget {
  final FilmeDetalheBloc filmeDetalheBloc;

  FilmeDetalheBlocProvider({Key key, Widget child})
      : filmeDetalheBloc = FilmeDetalheBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static FilmeDetalheBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(FilmeDetalheBlocProvider)
            as FilmeDetalheBlocProvider)
        .filmeDetalheBloc;
  }
}