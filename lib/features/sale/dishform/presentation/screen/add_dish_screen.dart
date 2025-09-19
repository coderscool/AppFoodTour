import 'package:appfoodtour/core/widgets/custom_text_field.dart';
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

  final List<String> nations = ["Việt Nam", "Thái Lan", "Nhật Bản", "Hàn Quốc"];
  final List<String> categoriesAll = ["Món chính", "Ăn vặt", "Tráng miệng", "Nước uống"];

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

    // TODO: Call API to submit `dishData`
  }

  void _selectNation() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Chọn quốc gia"),
          children: nations.map((nation) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, nation),
              child: Text(nation),
            );
          }).toList(),
        );
      },
    );

    if (result != null) {
      setState(() {
        nationController.text = result;
      });
    }
  }

  void _selectCategories() async {
    final tempSelected = [...categories];

    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Chọn danh mục"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: categoriesAll.map((cat) {
                    final selected = tempSelected.contains(cat);
                    return CheckboxListTile(
                      title: Text(cat),
                      value: selected,
                      onChanged: (val) {
                        setStateDialog(() {
                          if (val == true) {
                            tempSelected.add(cat);
                          } else {
                            tempSelected.remove(cat);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Hủy"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, tempSelected),
                  child: const Text("Xong"),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        categories
          ..clear()
          ..addAll(result);
      });
    }
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
            const Text('Topping / Extra', style: TextStyle(fontWeight: FontWeight.bold)),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: discountController,
                    hintText: "Topping",
                    validator: (value) =>
                    (value == null || value.isEmpty) ? "Please enter email/phone" : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomTextField(
                    controller: discountController,
                    hintText: "Giá",
                    validator: (value) =>
                    (value == null || value.isEmpty) ? "Please enter email/phone" : null,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: addExtra,
                  icon: const Icon(Icons.add),
                  label: const Text("Thêm"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(extras.length, (index) {
                final e = extras[index];
                return Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${e['price']} đ",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // nút x góc phải
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            extras.removeAt(index);
                          });
                        },
                        child: const Text(
                          "x",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 20),
            const Text('Tìm kiếm (Search)', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: nationController,
              readOnly: true, // chặn nhập tay
              onTap: _selectNation,
              decoration: const InputDecoration(labelText: 'Quốc gia'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: categoryController,
                    readOnly: true,
                    onTap: _selectCategories,
                    decoration: const InputDecoration(labelText: 'Danh mục'),
                  ),
                ),
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

