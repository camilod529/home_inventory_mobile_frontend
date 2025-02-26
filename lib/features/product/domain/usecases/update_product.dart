import 'package:dartz/dartz.dart';
import 'package:home_inventory_app/core/errors/failures.dart';
import 'package:home_inventory_app/features/product/domain/entities/product.dart';
import 'package:home_inventory_app/features/product/domain/repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  Future<Either<Failure, Product>> call(String productId, Product product) {
    return repository.updateProduct(productId, product);
  }
}
