import 'package:home_inventory_app/features/product/domain/entities/product.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {
  final String inventoryId;
  LoadProducts(this.inventoryId);
}

class CreateProductEvent extends ProductEvent {
  final Product product;
  CreateProductEvent(this.product);
}
