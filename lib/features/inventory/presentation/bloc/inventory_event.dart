import 'package:equatable/equatable.dart';

abstract class InventoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Evento para obtener los inventarios del usuario.
class LoadUserInventories extends InventoryEvent {}

/// Evento para crear un inventario.
class AddInventory extends InventoryEvent {
  final String name;

  AddInventory(this.name);

  @override
  List<Object?> get props => [name];
}

/// Evento para unirse a un inventario con código.
class EnterInventory extends InventoryEvent {
  final String code;

  EnterInventory(this.code);

  @override
  List<Object?> get props => [code];
}
