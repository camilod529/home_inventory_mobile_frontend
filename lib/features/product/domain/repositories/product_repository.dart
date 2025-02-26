import 'package:dartz/dartz.dart';
import 'package:home_inventory_app/core/errors/failures.dart';
import 'package:home_inventory_app/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProductsByInventory(
    String inventoryId,
  );
  Future<Either<Failure, Product>> createProduct(Product product);
}
