import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String? description;
  final double quantity;
  final String unit;
  final String inventoryId;
  final String? expirationDate;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unit,
    required this.inventoryId,
    this.expirationDate,
  });

  factory Product.empty() {
    return Product(
      id: '',
      name: '',
      description: '',
      quantity: 0,
      unit: '',
      inventoryId: '',
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    quantity,
    unit,
    inventoryId,
    expirationDate,
  ];
}
