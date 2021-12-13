import 'dart:convert';

import 'package:rick_and_morty_app/core/error/exeption.dart';
import 'package:rick_and_morty_app/feature/data/model/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSourse {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

const cachedPersonsListKey = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourseImpl implements PersonLocalDataSourse {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourseImpl({required this.sharedPreferences});
  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(cachedPersonsListKey);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheExeption();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();
    sharedPreferences.setStringList(cachedPersonsListKey, jsonPersonsList);

    return Future.value(jsonPersonsList);
  }
}
