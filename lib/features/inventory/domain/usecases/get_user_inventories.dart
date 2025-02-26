import 'package:dartz/dartz.dart';
import 'package:home_inventory_app/core/usecase/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/inventory.dart';
import '../repositories/inventory_repository.dart';

class GetUserInventories implements UseCase<List<Inventory>, NoParams> {
  final InventoryRepository repository;

  GetUserInventories(this.repository);

  @override
  Future<Either<Failure, List<Inventory>>> call(NoParams params) {
    return repository.getUserInventories();
  }
}
