import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unit_and_widget_tests/person.dart';
import 'package:flutter_unit_and_widget_tests/person_bloc.dart';
import 'package:flutter_unit_and_widget_tests/person_repository.dart';
import 'package:flutter_unit_and_widget_tests/person_state.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {
  final repository = PersonRepositoryMock();
  final bloc = PersonBloc(repository);
  final person = Person(id: 1, name: 'Paulo', age: 43, height: 1.69, weight: 94.4);

  test('deve retorna uma lista de person', () async {
    when(() => repository.getPerson()).thenAnswer((_) async => <Person>[person, person]);

    bloc.add(PersonEvent.fetch);

    await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PersonLoadingState>(),
          isA<PersonListState>(),
        ]));
  });

  test('deve disparar um error', () async {
    when(() => repository.getPerson()).thenThrow(Exception('deu error'));

    bloc.add(PersonEvent.fetch);

    await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PersonLoadingState>(),
          isA<PersonErrorState>(),
        ]));
  });
}
