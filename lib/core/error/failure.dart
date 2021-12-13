import 'package:equatable/equatable.dart';


/*
Поскольку ошибки будут встречаться по всему приложению, выносим класс в общую 
папку с проектом 
*/

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}
class CacheFailure extends Failure {}