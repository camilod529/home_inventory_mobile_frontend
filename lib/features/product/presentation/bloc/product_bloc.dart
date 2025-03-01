import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_app/features/product/domain/usecases/create_product.dart';
import 'package:home_inventory_app/features/product/domain/usecases/delete_product.dart';
import 'package:home_inventory_app/features/product/domain/usecases/get_products.dart';
import 'package:home_inventory_app/features/product/domain/usecases/update_product.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_event.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final CreateProduct createProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  ProductBloc(
    this.getProducts,
    this.createProduct,
    this.updateProduct,
    this.deleteProduct,
  ) : super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
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

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final response = await updateProduct(event.productId, event.product);
    response.fold((failure) => emit(ProductError(failure.toString())), (_) {
      emit(UpdateProductSuccess());
      add(LoadProducts(event.product.inventoryId));
    });
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final response = await deleteProduct(event.productId);
    response.fold((failure) => emit(ProductError(failure.toString())), (_) {
      emit(DeleteProductSuccess());
      add(LoadProducts(event.productId));
    });
  }
}
