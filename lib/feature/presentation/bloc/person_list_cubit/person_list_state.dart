import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  final List<PersonEntity> oldPersonsList;
  final bool isFirstFetch;

  PersonLoading({required this.oldPersonsList, required this.isFirstFetch});

  @override
  List<Object?> get props => [oldPersonsList, isFirstFetch];
}

class PersonLoaded extends PersonState {
  final List<PersonEntity> personsList;

  PersonLoaded(this.personsList);

  @override
  List<Object?> get props => [];
}

class PersonError extends PersonState {
  final String message;

  PersonError({required this.message});

  @override
  List<Object?> get props => [message];
}
