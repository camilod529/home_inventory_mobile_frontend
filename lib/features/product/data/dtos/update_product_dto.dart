import 'package:equatable/equatable.dart';

class UpdateProductDto extends Equatable {
  final String name;
  final String? description;
  final double quantity;
  final String unit;
  final String? expirationDate;
  final String inventoryId;

  const UpdateProductDto({
    required this.name,
    this.description,
    required this.quantity,
    required this.unit,
    this.expirationDate,
    required this.inventoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'unit': unit,
      'expirationDate': expirationDate,
      'inventoryId': inventoryId,
    };
  }

  @override
  List<Object?> get props => [
    name,
    description,
    quantity,
    unit,
    expirationDate,
    inventoryId,
  ];
}
