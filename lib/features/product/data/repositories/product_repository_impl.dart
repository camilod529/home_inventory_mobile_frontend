import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:home_inventory_app/core/errors/failures.dart';
import 'package:home_inventory_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:home_inventory_app/features/product/data/dtos/create_product_dto.dart';
import 'package:home_inventory_app/features/product/data/dtos/update_product_dto.dart';
import 'package:home_inventory_app/features/product/domain/entities/product.dart';
import 'package:home_inventory_app/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProductsByInventory(
    String inventoryId,
  ) async {
    try {
      final products = await remoteDataSource.getProductsByInventory(
        inventoryId,
      );
      return Right(products);
    } on DioException catch (e) {
      print(e);
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    try {
      final dto = CreateProductDTO(
        name: product.name,
        description: product.description ?? '',
        quantity: product.quantity,
        unit: product.unit,
        inventoryId: product.inventoryId,
      );

      final productCreated = await remoteDataSource.createProduct(dto);
      return Right(productCreated);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(
    String productId,
    Product product,
  ) async {
    try {
      final dto = UpdateProductDto(
        name: product.name,
        description: product.description ?? '',
        quantity: product.quantity,
        unit: product.unit,
        inventoryId: product.inventoryId,
      );

      final productUpdated = await remoteDataSource.updateProduct(
        productId,
        dto,
      );

      return Right(productUpdated);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
