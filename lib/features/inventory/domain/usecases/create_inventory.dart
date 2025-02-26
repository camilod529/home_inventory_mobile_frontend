import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/inventory.dart';
import '../repositories/inventory_repository.dart';

class CreateInventory implements UseCase<Inventory, CreateInventoryParams> {
  final InventoryRepository repository;

  CreateInventory(this.repository);

  @override
  Future<Either<Failure, Inventory>> call(CreateInventoryParams params) {
    return repository.createInventory(params.name);
  }
}

class CreateInventoryParams {
  final String name;

  CreateInventoryParams(this.name);
}
