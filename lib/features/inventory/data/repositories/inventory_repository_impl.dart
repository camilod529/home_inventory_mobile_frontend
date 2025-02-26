import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:home_inventory_app/core/errors/failures.dart';
import '../../domain/entities/inventory.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../datasources/inventory_remote_data_source.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryRemoteDataSource remoteDataSource;

  InventoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Inventory>> createInventory(String name) async {
    try {
      final inventory = await remoteDataSource.createInventory(name);
      return Right(inventory);
    } on DioException catch (e) {
      print(e);
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Inventory>> joinInventory(String code) async {
    try {
      final inventory = await remoteDataSource.joinInventory(code);
      return Right(inventory);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Inventory>>> getUserInventories() async {
    try {
      final inventories = await remoteDataSource.getInventories();
      return Right(inventories);
    } on DioException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
