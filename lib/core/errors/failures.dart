import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// Error de servidor (API)
class ServerFailure extends Failure {}

// Error de caché (base de datos local)
class CacheFailure extends Failure {}
