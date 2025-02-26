import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_event.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_state.dart';

class InventorySelectionPage extends StatefulWidget {
  const InventorySelectionPage({super.key});

  @override
  State<InventorySelectionPage> createState() => _InventorySelectionPageState();
}

class _InventorySelectionPageState extends State<InventorySelectionPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  void _createInventory(BuildContext context) {
    final name = nameController.text.trim();
    if (name.isNotEmpty) {
      context.read<InventoryBloc>().add(AddInventory(name));
    }
  }

  void _joinInventory(BuildContext context) {
    final code = codeController.text.trim();
    if (code.isNotEmpty) {
      context.read<InventoryBloc>().add(EnterInventory(code));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Inventory")),
      body: BlocListener<InventoryBloc, InventoryState>(
        listener: (context, state) {
          if (state is InventorySuccess) {
            context.go('/inventory-list');
          } else if (state is InventoryError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "To get started, create a new inventory or join an existing one.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Input field to create inventory
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Inventory Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Button to create inventory
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _createInventory(context),
                  icon: const Icon(Icons.add),
                  label: const Text("Create Inventory"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Input field to join an inventory
              TextField(
                controller: codeController,
                decoration: InputDecoration(
                  labelText: "Inventory Code",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Button to join an inventory
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _joinInventory(context),
                  child: const Text("Join Inventory"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
