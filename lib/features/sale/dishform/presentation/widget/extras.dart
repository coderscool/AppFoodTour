import 'package:appfoodtour/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/dish.dart';

class ExtrasWidget extends StatefulWidget {
  final List<Extra> extras;
  final ValueChanged<List<Extra>> onChanged;

  const ExtrasWidget({
    super.key,
    required this.extras,
    required this.onChanged,
  });

  @override
  State<ExtrasWidget> createState() => _ExtrasWidgetState();
}

class _ExtrasWidgetState extends State<ExtrasWidget> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  void _addExtra() {
    if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
      final updated = [...widget.extras];
      updated.add(
        Extra(
          name: nameController.text,
          price: double.tryParse(priceController.text) ?? 0,
        ),
      );
      widget.onChanged(updated);
      nameController.clear();
      priceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Topping / Extra", style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: nameController,
                hintText: "Topping",
                validator: (value) =>
                (value == null || value.isEmpty) ? "Please enter email/phone" : null,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                controller: priceController,
                hintText: "Giá",
                validator: (value) =>
                (value == null || value.isEmpty) ? "Please enter email/phone" : null,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _addExtra,
              icon: const Icon(Icons.add),
              label: const Text("Thêm"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          children: widget.extras.map((e) {
            return Chip(
              label: Text("${e.name} (${e.price} đ)"),
              onDeleted: () {
                final updated = [...widget.extras]..remove(e);
                widget.onChanged(updated);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
