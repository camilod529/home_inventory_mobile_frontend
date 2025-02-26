import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:home_inventory_app/core/errors/failures.dart';
import 'package:home_inventory_app/features/product/data/datasources/product_remote_data_source.dart';
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
}
