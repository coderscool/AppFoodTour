import 'package:flutter/material.dart';

class AddDishScreen extends StatefulWidget {
  const AddDishScreen({Key? key}) : super(key: key);

  @override
  State<AddDishScreen> createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final descriptionController = TextEditingController();

  final costController = TextEditingController();
  final discountController = TextEditingController();
  final quantityController = TextEditingController();

  final extraNameController = TextEditingController();
  final extraPriceController = TextEditingController();

  final nationController = TextEditingController();
  final categoryController = TextEditingController();

  List<Map<String, dynamic>> extras = [];
  List<String> categories = [];

  void addExtra() {
    if (extraNameController.text.isNotEmpty && extraPriceController.text.isNotEmpty) {
      setState(() {
        extras.add({
          'name': extraNameController.text,
          'price': double.tryParse(extraPriceController.text) ?? 0,
        });
        extraNameController.clear();
        extraPriceController.clear();
      });
    }
  }

  void addCategory() {
    if (categoryController.text.isNotEmpty) {
      setState(() {
        categories.add(categoryController.text);
        categoryController.clear();
      });
    }
  }

  void submitDish() {
    final Map<String, dynamic> dishData = {
      "dish": {
        "name": nameController.text,
        "image": imageController.text,
        "description": descriptionController.text,
      },
      "extra": extras,
      "price": {
        "cost": double.tryParse(costController.text) ?? 0,
        "discount": double.tryParse(discountController.text) ?? 0,
      },
      "quantity": int.tryParse(quantityController.text) ?? 0,
      "search": {
        "nation": nationController.text,
        "category": categories,
      }
    };

    print("Dish JSON:\n$dishData");

    // TODO: Call API to submit `dishData`
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm Món Ăn')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Thông tin món ăn', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Tên món')),
            TextField(controller: imageController, decoration: const InputDecoration(labelText: 'Link ảnh')),
            TextField(controller: descriptionController, decoration: const InputDecoration(labelText: 'Mô tả')),

            const SizedBox(height: 20),
            const Text('Giá món ăn', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: costController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Giá gốc')),
            TextField(controller: discountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Giảm giá')),

            const SizedBox(height: 20),
            const Text('Số lượng', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: quantityController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Số lượng')),

            const SizedBox(height: 20),
            const Text('Topping / Extra', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(child: TextField(controller: extraNameController, decoration: const InputDecoration(labelText: 'Tên'))),
                const SizedBox(width: 8),
                Expanded(child: TextField(controller: extraPriceController, decoration: const InputDecoration(labelText: 'Giá'), keyboardType: TextInputType.number)),
                IconButton(onPressed: addExtra, icon: const Icon(Icons.add)),
              ],
            ),
            for (var e in extras) Text('${e['name']} - ${e['price']}đ'),

            const SizedBox(height: 20),
            const Text('Tìm kiếm (Search)', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: nationController, decoration: const InputDecoration(labelText: 'Quốc gia')),
            Row(
              children: [
                Expanded(child: TextField(controller: categoryController, decoration: const InputDecoration(labelText: 'Danh mục'))),
                IconButton(onPressed: addCategory, icon: const Icon(Icons.add)),
              ],
            ),
            Wrap(
              spacing: 8,
              children: categories.map((cat) => Chip(label: Text(cat))).toList(),
            ),

            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: submitDish,
                icon: const Icon(Icons.check),
                label: const Text('Thêm món ăn'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

