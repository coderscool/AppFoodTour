import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

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
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nationController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  File? _selectedImage; // ảnh chọn từ gallery
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      List<Location> locations =
      await locationFromAddress(addressController.text.trim());
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;

      final body = {
        "userName": usernameController.text.trim(),
        "passWord": passwordController.text.trim(),
        "seller": {
          "name": nameController.text.trim(),
          "image": _selectedImage?.path ?? "", // lưu path tạm
          "address": {
            "address": addressController.text.trim(),
            "latitude": latitude,
            "longitude": longitude,
          },
          "phone": phoneController.text.trim()
        },
        "image": _selectedImage?.path ?? "",
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
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng ký thành công')),
          );
          Navigator.pop(context);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể lấy vị trí từ địa chỉ: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildImagePicker() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
              image: _selectedImage != null
                  ? DecorationImage(
                image: FileImage(_selectedImage!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: _selectedImage == null
                ? const Center(
              child: Text(
                "Chưa chọn ảnh",
                style: TextStyle(color: Colors.grey),
              ),
            )
                : null,
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: InkWell(
              onTap: _pickImage,
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade600,
                radius: 20,
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    nationController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),

                const Text(
                  "Đăng ký Người bán",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                /// Avatar + nút chọn ảnh
                _buildImagePicker(),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: usernameController,
                  hintText: "Username",
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: nameController,
                  hintText: "Tên cửa hàng",
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: addressController,
                  hintText: "Địa chỉ",
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: phoneController,
                  hintText: "Số điện thoại",
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: nationController,
                  hintText: "Quốc gia",
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: startTimeController,
                        hintText: "Giờ mở cửa (0-23)",
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        controller: endTimeController,
                        hintText: "Giờ đóng cửa (0-23)",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                PrimaryButton(
                  title: _isLoading ? "Đang xử lý..." : "Đăng ký",
                  onPressed: _submitForm,
                  height: 50,
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Quay lại đăng nhập",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


