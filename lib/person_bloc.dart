import 'package:bloc/bloc.dart';
import 'package:flutter_unit_and_widget_tests/person_bloc.dart';
import 'package:flutter_unit_and_widget_tests/person_bloc.dart';
import 'package:flutter_unit_and_widget_tests/person_state.dart';

import 'person_repository.dart';

enum PersonEvent { clear, fetch }

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository repository;

  PersonBloc(this.repository) : super(PersonListState([]));

  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event == PersonEvent.clear) {
      yield PersonListState([]);
    } else if (event == PersonEvent.fetch) {
      yield PersonLoadingState();
      try {
        final list = await repository.getPerson();
        yield PersonListState(list);
      } catch (e) {
        yield PersonErrorState(e);
      }
    }
  }
}
