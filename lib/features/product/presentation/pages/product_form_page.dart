import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_inventory_app/features/product/domain/entities/product.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_event.dart';

class ProductFormPage extends StatefulWidget {
  final String inventoryId;
  final String? productId;

  const ProductFormPage({super.key, required this.inventoryId, this.productId});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.productId ?? '',
        name: _nameController.text,
        description: _descriptionController.text,
        quantity: int.parse(_quantityController.text),
        unit: _unitController.text,
        inventoryId: widget.inventoryId,
      );

      context.read<ProductBloc>().add(CreateProductEvent(product));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productId == null ? "Agregar Producto" : "Editar Producto",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator:
                    (value) => value!.isEmpty ? "Ingrese el nombre" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Descripción"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: "Cantidad"),
                keyboardType: TextInputType.number,
                validator:
                    (value) => value!.isEmpty ? "Ingrese la cantidad" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _unitController,
                decoration: const InputDecoration(
                  labelText: "Unidad (Ej: L, KG, Piezas)",
                ),
                validator:
                    (value) => value!.isEmpty ? "Ingrese la unidad" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  widget.productId == null ? "Guardar" : "Actualizar",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
