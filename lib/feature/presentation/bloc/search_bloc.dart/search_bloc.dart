import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/search_person.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc.dart/search_event.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc.dart/search_state.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPersons;
  PersonSearchBloc({required this.searchPersons}) : super(PersonSearchEmpty()) {
    on<SearchPersons>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SearchPersons event, Emitter<PersonSearchState> emit) async {
    emit(PersonSearchLoading());
    final failureOrPerson =
        await searchPersons(SearchPersonParams(query: event.personQuery));
    emit(failureOrPerson.fold(
        (failure) =>
            PersonSearchErrorState(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "SERVER_FAILURE_MESSAGE";
      case CacheFailure:
        return 'ACHED_FAILURE_MESSAGE';
      default:
        return 'Unexpected Error';
    }
  }
}
