import 'package:equatable/equatable.dart';
import '../../domain/entities/inventory.dart';

abstract class InventoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial (cuando no se ha hecho ninguna acción).
class InventoryInitial extends InventoryState {}

/// Estado de carga (cuando se está obteniendo, creando o uniendo inventarios).
class InventoryLoading extends InventoryState {}

/// Estado cuando se obtienen los inventarios correctamente.
class InventoryLoaded extends InventoryState {
  final List<Inventory> inventories;

  InventoryLoaded(this.inventories);

  @override
  List<Object?> get props => [inventories];
}

/// Estado cuando se crea o se une a un inventario exitosamente.
class InventorySuccess extends InventoryState {
  final Inventory inventory;

  InventorySuccess(this.inventory);

  @override
  List<Object?> get props => [inventory];
}

/// Estado cuando ocurre un error.
class InventoryError extends InventoryState {
  final String message;

  InventoryError(this.message);

  @override
  List<Object?> get props => [message];
}
