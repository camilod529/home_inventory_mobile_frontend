import 'package:dio/dio.dart';
import 'package:home_inventory_app/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProductsByInventory(String inventoryId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getProductsByInventory(String inventoryId) async {
    final response = await dio.get('/products/$inventoryId');
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Error loading products");
    }
  }
}
