import '../../domain/entities/inventory.dart';

class InventoryModel extends Inventory {
  const InventoryModel({
    required super.id,
    required super.name,
    required super.code,
    required super.ownerId,
    required super.members,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'ownerId': ownerId, 'members': members};
  }
}
