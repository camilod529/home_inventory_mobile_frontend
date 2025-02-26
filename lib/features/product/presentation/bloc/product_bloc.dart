import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_app/features/product/domain/usecases/create_product.dart';
import 'package:home_inventory_app/features/product/domain/usecases/get_products.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_event.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final CreateProduct createProduct;

  ProductBloc(this.getProducts, this.createProduct) : super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<CreateProductEvent>(_onCreateProduct);
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

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final response = await createProduct(event.product);
    response.fold((failure) => emit(ProductError(failure.toString())), (_) {
      emit(CreateProductSuccess());
      add(LoadProducts(event.product.inventoryId));
    });
  }
}
