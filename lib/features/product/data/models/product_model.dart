import 'package:home_inventory_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    super.description,
    required super.quantity,
    required super.unit,
    required super.inventoryId,
    super.expirationDate,
  });

  factory ProductModel.empty() {
    return ProductModel(
      id: '',
      name: '',
      description: '',
      quantity: 0,
      unit: '',
      inventoryId: '',
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      quantity:
          (json['quantity'] is num)
              ? (json['quantity'] as num).toDouble()
              : double.tryParse(json['quantity'].toString()) ?? 0.0,
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
