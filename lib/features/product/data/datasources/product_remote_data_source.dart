import 'package:dio/dio.dart';
import 'package:home_inventory_app/features/product/data/dtos/create_product_dto.dart';
import 'package:home_inventory_app/features/product/data/dtos/update_product_dto.dart';
import 'package:home_inventory_app/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProductsByInventory(String inventoryId);
  Future<ProductModel> createProduct(CreateProductDTO product);
  Future<ProductModel> updateProduct(String productId, UpdateProductDto dto);
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

  @override
  Future<ProductModel> createProduct(CreateProductDTO productDTO) async {
    final response = await dio.post('/products', data: productDTO.toJson());
    if (response.statusCode == 201) {
      return ProductModel.fromJson(response.data);
    } else {
      throw Exception("Error creating product");
    }
  }

  @override
  Future<ProductModel> updateProduct(
    String productId,
    UpdateProductDto dto,
  ) async {
    final response = await dio.patch(
      '/products/$productId',
      data: dto.toJson(),
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(response.data);
    } else {
      throw Exception("Error updating product");
    }
  }
}
