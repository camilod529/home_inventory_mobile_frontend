import 'package:home_inventory_app/features/product/data/models/product_model.dart';

import '../../domain/entities/inventory.dart';

class InventoryModel extends Inventory {
  const InventoryModel({
    required super.id,
    required super.name,
    required super.code,
    required super.ownerId,
    required super.members,
    required super.products,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      ownerId: json['owner']?['id'],
      members:
          (json['members'] as List<dynamic>?)
              ?.map(
                (member) => member['id'] as String,
              ) // Extraer IDs de los miembros
              .toList() ??
          [],
      products:
          (json['products'] as List<dynamic>?)
              ?.map((productJson) => ProductModel.fromJson(productJson))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'ownerId': ownerId, 'members': members};
  }
}
