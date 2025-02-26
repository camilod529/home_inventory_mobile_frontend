import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_event.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_state.dart';

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
      context.read<ProductBloc>().add(LoadProducts(widget.inventoryId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.inventoryName)),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return state.products.isEmpty
                ? const Center(
                  child: Text(
                    "No hay productos en este inventario",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        leading: const Icon(
                          Icons.shopping_basket,
                          color: Colors.green,
                        ),
                        title: Text(product.name),
                        subtitle: Text(
                          "Cantidad: ${product.quantity} ${product.unit}",
                        ),
                      ),
                    );
                  },
                );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("Cargando productos..."));
          }
        },
      ),
    );
  }
}
