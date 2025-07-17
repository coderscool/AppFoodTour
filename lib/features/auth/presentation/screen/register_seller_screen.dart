import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';

class SellerRegisterScreen extends StatefulWidget {
  const SellerRegisterScreen({super.key});

  @override
  State<SellerRegisterScreen> createState() => _SellerRegisterScreenState();
}

class _SellerRegisterScreenState extends State<SellerRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nationController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Lấy vị trí từ địa chỉ
        List<Location> locations = await locationFromAddress(addressController.text.trim());
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;

        final body = {
          "userName": usernameController.text.trim(),
          "passWord": passwordController.text.trim(),
          "seller": {
            "name": nameController.text.trim(),
            "image": imageController.text.trim(),
            "address": {
              "address": addressController.text.trim(),
              "latitude": latitude,
              "longitude": longitude,
            },
            "phone": phoneController.text.trim()
          },
          "image": imageController.text.trim(),
          "nation": nationController.text.trim(),
          "timeActive": {
            "start": int.tryParse(startTimeController.text) ?? 0,
            "end": int.tryParse(endTimeController.text) ?? 0
          },
          "role": "seller"
        };

        final response = await http.post(
          Uri.parse('http://10.0.2.2:7275/sign-up/seller'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng ký thành công')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể lấy vị trí từ địa chỉ: $e')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đăng ký người bán")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(usernameController, "Username"),
              _buildField(passwordController, "Password", isPassword: true),
              _buildField(nameController, "Tên cửa hàng"),
              _buildField(imageController, "Ảnh (URL)"),
              _buildField(addressController, "Địa chỉ"),
              _buildField(phoneController, "Số điện thoại"),
              _buildField(nationController, "Quốc gia"),
              _buildField(startTimeController, "Giờ mở cửa (0-23)"),
              _buildField(endTimeController, "Giờ đóng cửa (0-23)"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Đăng ký"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) =>
        value == null || value.isEmpty ? "Vui lòng nhập $label" : null,
      ),
    );
  }
}

