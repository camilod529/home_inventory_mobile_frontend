import 'package:equatable/equatable.dart';
import 'package:home_inventory_app/features/product/domain/entities/product.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {
  final String inventoryId;
  LoadProducts(this.inventoryId);
}

class CreateProductEvent extends ProductEvent {
  final Product product;
  CreateProductEvent(this.product);
}

class UpdateProductEvent extends ProductEvent {
  final String productId;
  final Product product;
  UpdateProductEvent(this.productId, this.product);

  @override
  List<Object> get props => [productId, product];
}

class DeleteProductEvent extends ProductEvent {
  final String productId;
  DeleteProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
