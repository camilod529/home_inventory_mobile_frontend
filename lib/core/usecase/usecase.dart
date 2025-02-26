import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Clase base para todos los casos de uso en la aplicación.
/// [Type] representa el tipo de respuesta esperada.
/// [Params] representa los parámetros que recibe el caso de uso.
/// Si el caso de uso no necesita parámetros, se usa `NoParams`.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Clase para representar la ausencia de parámetros en un caso de uso.
class NoParams {}
