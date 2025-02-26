import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_event.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_state.dart';

class InventoryListPage extends StatelessWidget {
  const InventoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Inventories")),
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          if (state is InventoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InventoryLoaded) {
            return ListView.builder(
              itemCount: state.inventories.length,
              itemBuilder: (context, index) {
                final inventory = state.inventories[index];
                return ListTile(
                  title: Text(inventory.name),
                  subtitle: Text("Code: ${inventory.code}"),
                  onTap: () {
                    // Aquí podrías navegar al detalle del inventario
                  },
                );
              },
            );
          } else if (state is InventoryError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No inventories found."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<InventoryBloc>().add(LoadUserInventories());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
