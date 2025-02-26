import 'package:equatable/equatable.dart';

class CreateProductDTO extends Equatable {
  final String name;
  final String description;
  final int quantity;
  final String unit;
  final String inventoryId;

  const CreateProductDTO({
    required this.name,
    required this.description,
    required this.quantity,
    required this.unit,
    required this.inventoryId,
  });

  /// Convierte el DTO a JSON para enviarlo en la petición
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'unit': unit,
      'inventoryId': inventoryId,
    };
  }

  @override
  List<Object> get props => [name, description, quantity, unit, inventoryId];
}
