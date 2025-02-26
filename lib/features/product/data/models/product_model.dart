import 'package:home_inventory_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.quantity,
    required super.unit,
    required super.inventoryId,
    super.expirationDate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      quantity: json['quantity'],
      unit: json['unit'],
      inventoryId: json['inventory']['id'],
      expirationDate: json['expirationDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'unit': unit,
      'inventoryId': inventoryId,
      'expirationDate': expirationDate,
    };
  }
}
