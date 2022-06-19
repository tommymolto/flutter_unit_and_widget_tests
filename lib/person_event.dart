import 'package:flutter_unit_and_widget_tests/person.dart';
import 'package:flutter_unit_and_widget_tests/person_bloc.dart';

abstract class PersonEvent{

}

class ClearPersonEvent extends PersonEvent{}
class FetchPersonFetch extends PersonEvent{}