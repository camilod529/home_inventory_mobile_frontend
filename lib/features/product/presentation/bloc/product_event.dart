abstract class ProductEvent {}

class LoadProducts extends ProductEvent {
  final String inventoryId;
  LoadProducts(this.inventoryId);
}
