// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unit_and_widget_tests/person_state.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_unit_and_widget_tests/bloc_provider.dart';
import 'package:flutter_unit_and_widget_tests/home_page.dart';

import 'package:flutter_unit_and_widget_tests/main.dart';
import 'package:flutter_unit_and_widget_tests/person.dart';
import 'package:flutter_unit_and_widget_tests/person_bloc.dart';
import 'package:flutter_unit_and_widget_tests/person_repository.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {
  final repository = PersonRepositoryMock();
  final bloc = PersonBloc(repository);

  final person = Person(id: 1, name: 'Jacob', age: 29, height: 1.77, weight: 64.4);
  testWidgets('Deve mostrar todos os estados na tela', (WidgetTester tester) async {
    when(() => repository.getPerson()).thenAnswer((_) async => <Person>[person, person]);

    await tester.pumpWidget(MaterialApp(home: BlocProvider(bloc: bloc, child: HomePage())));

    final textButton = find.byType(TextButton);
    expect(textButton, findsOneWidget);
    final loading = find.byType(CircularProgressIndicator);
    expect(loading, findsNothing);
    final listPersons = find.byType(ListView);
    expect(listPersons, findsNothing);

    await tester.tap(textButton);

    //await tester.pump();
    //await tester.runAsync(() => bloc.stream.firstWhere((element) => element == PersonLoadingState()));
    //expect(loading, findsOneWidget);

    await tester.runAsync(() => bloc.stream.first);
    await tester.pump();
    expect(listPersons, findsOneWidget);
  });
}
