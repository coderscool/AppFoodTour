import 'package:appfoodtour/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/dish.dart';
import 'extras.dart';
import 'category_selector.dart';
import 'nation_selector.dart';

class DishForm extends StatefulWidget {
  final void Function(Dish dish) onSubmit;

  const DishForm({super.key, required this.onSubmit});

  @override
  State<DishForm> createState() => _DishFormState();
}

class _DishFormState extends State<DishForm> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final costController = TextEditingController();
  final discountController = TextEditingController();
  final quantityController = TextEditingController();

  List<Extra> extras = [];
  List<String> categories = [];
  String nation = "";

  final nations = ["Việt Nam", "Thái Lan", "Nhật Bản", "Hàn Quốc"];
  final categoriesAll = ["Món chính", "Ăn vặt", "Tráng miệng", "Nước uống"];

  void _submit() {
    final dish = Dish(
      name: nameController.text,
      image: "",
      description: descriptionController.text,
      cost: double.tryParse(costController.text) ?? 0,
      discount: double.tryParse(discountController.text) ?? 0,
      quantity: int.tryParse(quantityController.text) ?? 0,
      extras: extras,
      categories: categories,
      nation: nation,
    );
    widget.onSubmit(dish);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Thông tin món ăn', style: TextStyle(fontWeight: FontWeight.bold)),
          CustomTextField(
            controller: nameController,
            hintText: "Tên món",
            validator: (value) =>
            (value == null || value.isEmpty) ? "Please enter email/phone" : null,
          ),
          CustomTextField(
            controller: descriptionController,
            hintText: "Mô tả",
            validator: (value) =>
            (value == null || value.isEmpty) ? "Please enter email/phone" : null,
          ),

          const SizedBox(height: 20),
          const Text('Giá món ăn', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Expanded(
                flex: 3, // chiếm 3 phần
                child: CustomTextField(
                  controller: costController,
                  hintText: "Giá gốc",
                  validator: (value) =>
                  (value == null || value.isEmpty) ? "Please enter email/phone" : null,
                ),
              ),
              SizedBox(width: 10), // khoảng cách
              Expanded(
                flex: 1, // chiếm 1 phần
                child: CustomTextField(
                  controller: discountController,
                  hintText: "Giảm giá",
                  validator: (value) =>
                  (value == null || value.isEmpty) ? "Please enter email/phone" : null,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Text('Số lượng', style: TextStyle(fontWeight: FontWeight.bold)),
          CustomTextField(
            controller: quantityController,
            hintText: "Số lượng",
            validator: (value) =>
            (value == null || value.isEmpty) ? "Please enter email/phone" : null,
          ),
          const SizedBox(height: 20),
          ExtrasWidget(
            extras: extras,
            onChanged: (list) => setState(() => extras = list),
          ),
          const SizedBox(height: 20),
          NationSelectorWidget(
            nations: nations,
            selected: nation,
            onChanged: (val) => setState(() => nation = val),
          ),
          const SizedBox(height: 20),
          CategorySelectorWidget(
            allCategories: categoriesAll,
            selected: categories,
            onChanged: (list) => setState(() => categories = list),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.check),
            label: const Text("Thêm món ăn"),
          ),
        ],
      ),
    );
  }
}

