import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_event.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_state.dart';
import 'package:home_inventory_app/features/product/presentation/widgets/product_item.dart';

class InventoryDetailPage extends StatefulWidget {
  final String inventoryName;
  final String inventoryId;

  const InventoryDetailPage({
    required this.inventoryName,
    required this.inventoryId,
    super.key,
  });

  @override
  State<InventoryDetailPage> createState() => _InventoryDetailPageState();
}

class _InventoryDetailPageState extends State<InventoryDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProducts();
    });
  }

  void _loadProducts() {
    context.read<ProductBloc>().add(LoadProducts(widget.inventoryId));
  }

  Future<void> _onRefresh() async {
    _loadProducts();
  }

  void _confirmDeleteProduct(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Eliminar producto"),
            content: const Text(
              "¿Estás seguro de que deseas eliminar este producto? Esta acción no se puede deshacer.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  context.read<ProductBloc>().add(
                    DeleteProductEvent(productId),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Eliminar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.inventoryName)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push(
            '/product-form',
            extra: {'inventoryId': widget.inventoryId},
          );
        },
        tooltip: "Agregar producto",
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is CreateProductSuccess ||
              state is UpdateProductSuccess ||
              state is DeleteProductSuccess) {
            _loadProducts();
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child:
                    state.products.isEmpty
                        ? const Center(
                          child: Text(
                            "No hay productos en este inventario",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductItem(
                              product: product,
                              onEdit: () async {
                                await context.push(
                                  '/product-form',
                                  extra: {
                                    'inventoryId': widget.inventoryId,
                                    'productId': product.id,
                                  },
                                );
                              },
                              onDelete:
                                  () => _confirmDeleteProduct(
                                    context,
                                    product.id,
                                  ),
                            );
                          },
                        ),
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text("Cargando productos..."));
            }
          },
        ),
      ),
    );
  }
}
