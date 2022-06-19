import 'dart:convert';

import 'package:http/http.dart' as http;

import 'person.dart';

class PersonRepository {
  final http.Client client;

  PersonRepository(this.client);

  Future<List<Person>> getPerson() async {
    final response = await client.get(Uri.parse('https://62afa00db0a980a2ef424a47.mockapi.io/api/v1/person'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((e) => Person.fromMap(e)).toList();
    } else {
      throw Exception('Error na internet');
    }
  }
}
