import 'package:equatable/equatable.dart';
import 'package:home_inventory_app/features/product/domain/entities/product.dart';

class Inventory extends Equatable {
  final String id;
  final String name;
  final String code;
  final String ownerId;
  final List<String> members;
  final List<Product> products;

  const Inventory({
    required this.id,
    required this.name,
    required this.code,
    required this.ownerId,
    required this.members,
    required this.products,
  });

  @override
  List<Object?> get props => [id, name, ownerId, members];
}
