import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchPersons extends PersonSearchEvent {
  final String personQuery;

  SearchPersons({required this.personQuery});
}
