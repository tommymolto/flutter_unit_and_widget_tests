import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_unit_and_widget_tests/person_bloc.dart';
import 'package:flutter_unit_and_widget_tests/person_repository.dart';

import 'bloc_provider.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(bloc: PersonBloc(PersonRepository(Client())), child: HomePage()),
    );
  }
}
