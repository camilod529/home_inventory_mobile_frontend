import 'package:flutter/material.dart';
import 'package:home_inventory_app/features/product/domain/entities/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Icon leadingIcon;

  const ProductItem({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    this.leadingIcon = const Icon(Icons.shopping_basket, color: Colors.green),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: leadingIcon,
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Cantidad: ${product.quantity} ${product.unit}"),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              onEdit();
            } else if (value == 'delete') {
              onDelete();
            }
          },
          itemBuilder:
              (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Editar')),
                const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
              ],
        ),
      ),
    );
  }
}
