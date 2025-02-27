import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_inventory_app/features/product/data/models/product_model.dart';
import 'package:home_inventory_app/features/product/domain/entities/product.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_event.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_state.dart';

class ProductFormPage extends StatefulWidget {
  final String inventoryId;
  final String? productId;

  const ProductFormPage({super.key, required this.inventoryId, this.productId});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Si se está editando un producto, buscarlo en el bloc y llenar los campos
    if (widget.productId != null) {
      final productState = context.read<ProductBloc>().state;
      if (productState is ProductLoaded) {
        final product = productState.products.firstWhere(
          (p) => p.id == widget.productId,
          orElse:
              () => ProductModel.empty(), // Producto vacío si no se encuentra
        );

        _nameController.text = product.name;
        _descriptionController.text = product.description ?? "";
        _quantityController.text = product.quantity.toString();
        _unitController.text = product.unit;
      }
    }
  }

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
        description:
            _descriptionController.text.isNotEmpty
                ? _descriptionController.text
                : null,
        quantity: int.parse(_quantityController.text),
        unit: _unitController.text,
        inventoryId: widget.inventoryId,
      );

      if (widget.productId == null) {
        context.read<ProductBloc>().add(CreateProductEvent(product));
      } else {
        final bloc = context.read<ProductBloc>();

        bloc.add(UpdateProductEvent(widget.productId!, product));
        // context.read<ProductBloc>().add(
        //   UpdateProductEvent(
        //     widget.productId!,
        //     Product(
        //       id: widget.productId!,
        //       name: product.name,
        //       description: product.description,
        //       quantity: product.quantity,
        //       unit: product.unit,
        //       expirationDate:
        //           null, // Puedes agregar un campo de fecha si lo deseas
        //       inventoryId: widget.inventoryId,
        //     ),
        //   ),
        // );
      }

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
