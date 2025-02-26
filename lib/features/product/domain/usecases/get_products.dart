import 'package:dartz/dartz.dart';
import 'package:home_inventory_app/core/errors/failures.dart';
import 'package:home_inventory_app/core/usecase/usecase.dart';
import 'package:home_inventory_app/features/product/domain/entities/product.dart';
import 'package:home_inventory_app/features/product/domain/repositories/product_repository.dart';

class GetProducts implements UseCase<List<Product>, String> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(String inventoryId) async {
    return await repository.getProductsByInventory(inventoryId);
  }
}
