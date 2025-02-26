import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InventorySelectionPage extends StatelessWidget {
  InventorySelectionPage({super.key});

  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Inventory")),
      body: Padding(
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

            // Button to create inventory
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.go('/create-inventory');
                },
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
                onPressed: () {
                  final code = codeController.text.trim();
                  if (code.isNotEmpty) {
                    context.go('/join-inventory/$code');
                  }
                },
                child: const Text("Join Inventory"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
