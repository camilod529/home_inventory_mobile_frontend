import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_app/features/product/domain/usecases/get_products.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_event.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc(this.getProducts) : super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    print(" Cargando productos para el inventario: ${event.inventoryId}");
    emit(ProductLoading());
    final response = await getProducts(event.inventoryId);
    response.fold(
      (failure) => emit(ProductError(failure.toString())),
      (products) => emit(ProductLoaded(products)),
    );
  }
}
