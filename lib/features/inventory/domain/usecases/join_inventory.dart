import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/inventory.dart';
import '../repositories/inventory_repository.dart';

class JoinInventory implements UseCase<Inventory, JoinInventoryParams> {
  final InventoryRepository repository;

  JoinInventory(this.repository);

  @override
  Future<Either<Failure, Inventory>> call(JoinInventoryParams params) {
    return repository.joinInventory(params.code);
  }
}

class JoinInventoryParams {
  final String code;

  JoinInventoryParams(this.code);
}
