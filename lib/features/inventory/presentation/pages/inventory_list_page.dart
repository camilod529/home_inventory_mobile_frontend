import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_event.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_state.dart';

class InventoryListPage extends StatelessWidget {
  const InventoryListPage({super.key});

  Future<void> _refreshInventories(BuildContext context) async {
    context.read<InventoryBloc>().add(LoadUserInventories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Inventories")),
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          if (state is InventoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InventoryLoaded) {
            return RefreshIndicator(
              onRefresh: () => _refreshInventories(context),
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.inventories.length,
                itemBuilder: (context, index) {
                  final inventory = state.inventories[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.inventory_2,
                        color: Colors.blue,
                      ),
                      title: Text(
                        inventory.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Code: ${inventory.code}"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Navegar al detalle del inventario
                        context.push(
                          '/inventory/${Uri.encodeComponent(inventory.id)}/${Uri.encodeComponent(inventory.name)}',
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state is InventoryError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No inventories found."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _refreshInventories(context),
        tooltip: "Refresh Inventories",
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
