import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/get_all_person.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/person_list_cubit/person_list_state.dart';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;
  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());

  void loadPersons() async {
    if (state is PersonLoading) return;

    final currentState = state;
    var oldPersons = <PersonEntity>[];
    int page = 1;
    if (currentState is PersonLoaded) {
      oldPersons = currentState.personsList;
    }

    emit(PersonLoading(oldPersonsList: oldPersons, isFirstFetch: page == 1));

    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    failureOrPerson.fold(
        (error) => PersonError(message: _mapFailureToMessage(error)), (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons.addAll(character);

      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'SERVER_FAILURE_MESSAGE';
      case CacheFailure:
        return 'CACHE_FAILURE_MESSAGE';
      default:
        return 'Unknown failure';
    }
  }
}
