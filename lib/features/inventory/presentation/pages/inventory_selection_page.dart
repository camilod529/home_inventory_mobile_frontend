import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InventorySelectionPage extends StatelessWidget {
  InventorySelectionPage({super.key});

  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seleccionar Inventario")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Bienvenido 🎉",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "Para comenzar, crea un nuevo inventario o únete a uno existente.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Botón para crear inventario
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.go('/create-inventory');
                },
                icon: const Icon(Icons.add),
                label: const Text("Crear Inventario"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Campo para unirse a un inventario
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: "Código de Inventario",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Botón para unirse
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final code = codeController.text.trim();
                  if (code.isNotEmpty) {
                    context.go('/join-inventory/$code');
                  }
                },
                child: const Text("Unirse al Inventario"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
