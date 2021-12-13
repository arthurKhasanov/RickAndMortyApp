import 'package:rick_and_morty_app/core/error/exeption.dart';
import 'package:rick_and_morty_app/core/platform/nework_info.dart';
import 'package:rick_and_morty_app/feature/data/datasourses/person_local_datasourse.dart';
import 'package:rick_and_morty_app/feature/data/datasourses/person_remote_datasourse.dart';
import 'package:rick_and_morty_app/feature/data/model/person_model.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonLocalDataSourse localDataSourse;
  final PersoneRemoteDataSourse remoteDataSourse;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.localDataSourse,
    required this.remoteDataSourse,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersones(int page) async {
    return await _getPersons(() {
      return remoteDataSourse.getAllPersons(page);
    });
    }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return remoteDataSourse.searchPerson(query);
    });
  }


  Future<Either<Failure, List<PersonModel>>> _getPersons(Future<List<PersonModel>> Function() getPersones) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersones();
        localDataSourse.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSourse.getLastPersonsFromCache();
        return Right(localPerson);
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }
}
