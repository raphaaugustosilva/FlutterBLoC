import 'package:arquitetura_bloc/blocs/favoritosBLoC.dart';
import 'package:arquitetura_bloc/blocs/videosBLoC.dart';
import 'package:arquitetura_bloc/helpers/apiHelper.dart';
import 'package:arquitetura_bloc/views/home.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

void main() {
  ApiHelper apiHelper = ApiHelper();
  apiHelper.pesquisar("eletro");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBLoC()),
        Bloc((i) => FavoritosBLoC()),
      ],
      child: MaterialApp(
        title: 'Flutter BLoC',
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
