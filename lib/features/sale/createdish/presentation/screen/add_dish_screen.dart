import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDishScreen extends StatefulWidget {
  const AddDishScreen({super.key});

  @override
  State<AddDishScreen> createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  File? _selectedImage;
  final _picker = ImagePicker();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();

  String? _selectedCountry;
  final List<String> _countries = ['Việt Nam', 'Thái Lan', 'Hàn Quốc', 'Nhật Bản'];

  final List<String> _dishTypes = ['Món chính', 'Khai vị', 'Tráng miệng', 'Nước uống'];
  final Set<String> _selectedTypes = {};

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  void _submitDish() {
    // Validate & gửi dữ liệu ở đây
    print('Tên món: ${_nameController.text}');
    print('Giá: ${_priceController.text}');
    print('Mô tả: ${_descController.text}');
    print('Quốc gia: $_selectedCountry');
    print('Loại món: $_selectedTypes');
    print('Ảnh: ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm món ăn'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh món ăn
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade100,
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(_selectedImage!, fit: BoxFit.cover),
                )
                    : const Center(
                  child: Text('Chọn ảnh món ăn',
                      style: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tên món
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Tên món ăn',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Giá tiền
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Giá tiền (VNĐ)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Mô tả
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Mô tả món ăn',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Quốc gia
            const Text('Chọn quốc gia', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedCountry,
              items: _countries
                  .map((country) => DropdownMenuItem(
                value: country,
                child: Text(country),
              ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedCountry = value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Loại món ăn
            const Text('Chọn loại món ăn', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _dishTypes.map((type) {
                final isSelected = _selectedTypes.contains(type);
                return ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTypes.add(type);
                      } else {
                        _selectedTypes.remove(type);
                      }
                    });
                  },
                  selectedColor: Colors.deepOrange.shade200,
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _submitDish,
                label: const Text('Thêm món ăn'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
