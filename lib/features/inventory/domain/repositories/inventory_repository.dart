import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/inventory.dart';

abstract class InventoryRepository {
  Future<Either<Failure, List<Inventory>>> getUserInventories();
  Future<Either<Failure, Inventory>> createInventory(String name);
  Future<Either<Failure, Inventory>> joinInventory(String code);
}
