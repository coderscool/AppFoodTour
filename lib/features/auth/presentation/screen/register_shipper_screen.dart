import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShipperRegisterScreen extends StatefulWidget {
  const ShipperRegisterScreen({super.key});

  @override
  State<ShipperRegisterScreen> createState() => _ShipperRegisterScreenState();
}

class _ShipperRegisterScreenState extends State<ShipperRegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? _imageFile;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _submit() {
    print('Username: ${usernameController.text}');
    print('Password: ${passwordController.text}');
    print('Name: ${nameController.text}');
    print('Phone: ${phoneController.text}');
    print('Image: ${_imageFile?.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký người giao hàng')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null ? const Icon(Icons.camera_alt, size: 40) : null,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(controller: usernameController, label: 'Tên đăng nhập'),
            _buildTextField(controller: passwordController, label: 'Mật khẩu', obscure: true),
            _buildTextField(controller: nameController, label: 'Họ tên'),
            _buildTextField(controller: phoneController, label: 'Số điện thoại', keyboard: TextInputType.phone),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _submit, child: const Text('Đăng ký')),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }
}
