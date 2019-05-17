import 'package:flutter/material.dart';
import 'view/listagemFilmesView.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: ListagemFilmesView(),
        ),
      );
  }
}