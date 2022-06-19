import 'package:bloc/bloc.dart';
import 'package:flutter_unit_and_widget_tests/person_bloc.dart';
import 'package:flutter_unit_and_widget_tests/person_bloc.dart';
import 'package:flutter_unit_and_widget_tests/person_event.dart';
import 'package:flutter_unit_and_widget_tests/person_state.dart';

import 'person_repository.dart';

//enum PersonEvent { clear, fetch }

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository repository;

  PersonBloc(this.repository) : super(PersonListState([])){
    on<ClearPersonEvent>((event, emit) => emit(PersonListState([])));
    on<FetchPersonFetch>((event, emit) async {
      emit(PersonLoadingState());
      try {
        final list = await repository.getPerson();
        emit(PersonListState(list));
      } catch (e) {
        emit(PersonErrorState(e));
      }
    });
  }

  /*Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event == ClearPersonEvent) {
      yield PersonListState([]);
    } else if (event == FetchPersonFetch) {
      yield PersonLoadingState();
      try {
        final list = await repository.getPerson();
        yield PersonListState(list);
      } catch (e) {
        yield PersonErrorState(e);
      }
    }
  }*/
}
