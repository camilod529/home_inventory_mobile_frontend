import 'package:dio/dio.dart';
import '../models/inventory_model.dart';

abstract class InventoryRemoteDataSource {
  Future<List<InventoryModel>> getInventories();
  Future<InventoryModel> createInventory(String name);
  Future<InventoryModel> joinInventory(String code);
}

class InventoryRemoteDataSourceImpl implements InventoryRemoteDataSource {
  final Dio dio;

  InventoryRemoteDataSourceImpl(this.dio);

  @override
  Future<List<InventoryModel>> getInventories() async {
    final response = await dio.get('/inventory');
    final List<dynamic> data = response.data;

    return data.map((json) => InventoryModel.fromJson(json)).toList();
  }

  @override
  Future<InventoryModel> createInventory(String name) async {
    final response = await dio.post('/inventory', data: {'name': name});
    return InventoryModel.fromJson(response.data);
  }

  @override
  Future<InventoryModel> joinInventory(String code) async {
    final response = await dio.post('/inventory/join', data: {'code': code});
    return InventoryModel.fromJson(response.data);
  }
}
