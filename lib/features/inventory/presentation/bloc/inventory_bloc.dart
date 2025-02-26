import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_user_inventories.dart';
import '../../domain/usecases/create_inventory.dart';
import '../../domain/usecases/join_inventory.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import 'inventory_event.dart';
import 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final GetUserInventories getUserInventories;
  final CreateInventory createInventory;
  final JoinInventory joinInventory;

  InventoryBloc({
    required this.getUserInventories,
    required this.createInventory,
    required this.joinInventory,
  }) : super(InventoryInitial()) {
    on<LoadUserInventories>(_onGetUserInventories);
    on<AddInventory>(_onCreateInventory);
    on<EnterInventory>(_onJoinInventory);
  }

  /// Obtiene la lista de inventarios del usuario.
  Future<void> _onGetUserInventories(
    LoadUserInventories event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoading());
    final result = await getUserInventories(NoParams());

    result.fold(
      (failure) => emit(InventoryError(_mapFailureToMessage(failure))),
      (inventories) => emit(InventoryLoaded(inventories)),
    );
  }

  /// Crea un inventario con el nombre proporcionado.
  Future<void> _onCreateInventory(
    AddInventory event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoading());
    final result = await createInventory(CreateInventoryParams(event.name));

    result.fold(
      (failure) => emit(InventoryError(_mapFailureToMessage(failure))),
      (inventory) => emit(InventorySuccess(inventory)),
    );
  }

  /// Se une a un inventario con el código proporcionado.
  Future<void> _onJoinInventory(
    EnterInventory event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoading());
    final result = await joinInventory(JoinInventoryParams(event.code));

    result.fold(
      (failure) => emit(InventoryError(_mapFailureToMessage(failure))),
      (inventory) => emit(InventorySuccess(inventory)),
    );
  }

  /// Mapea los errores a mensajes comprensibles.
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return "Error de servidor. Inténtalo de nuevo.";
    }
    return "Ocurrió un error inesperado.";
  }
}
