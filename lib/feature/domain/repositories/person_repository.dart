import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';

/*
  Здесь мы определили "контракт" для репозитория, 
  а реализовать контракт будем на уровне данных 
*/

abstract class PersonRepository {

  /*
  Используем класс Either из библиотеки dartz, тк по схеме Reco Coder'а 
  репозиторий может возвращать как сущности, так и ошибки
  */

  Future<Either<Failure, List<PersonEntity>>> getAllPersones(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
