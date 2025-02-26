import 'package:dartz/dartz.dart';
import 'package:home_inventory_app/core/errors/failures.dart';
import 'package:home_inventory_app/features/product/domain/entities/product.dart';
import 'package:home_inventory_app/features/product/domain/repositories/product_repository.dart';

class CreateProduct {
  final ProductRepository repository;

  CreateProduct(this.repository);

  Future<Either<Failure, Product>> call(Product product) {
    return repository.createProduct(product);
  }
}
