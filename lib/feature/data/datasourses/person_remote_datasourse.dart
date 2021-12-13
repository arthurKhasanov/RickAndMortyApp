import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/core/error/exeption.dart';
import 'package:rick_and_morty_app/feature/data/model/person_model.dart';

abstract class PersoneRemoteDataSourse {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourseImpl implements PersoneRemoteDataSourse {
  final http.Client client;

  PersonRemoteDataSourseImpl({required this.client});
  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    print(url);
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerExeption();
    }
  }
}
