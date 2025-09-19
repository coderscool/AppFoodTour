import 'dart:io';
import 'package:appfoodtour/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';

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

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      context.read<AuthBloc>().add(
        RegisterSellerEvent(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
          address: addressController.text.trim(),
          phone: phoneController.text.trim(),
          nation: nationController.text.trim(),
          startTime: int.tryParse(startTimeController.text) ?? 0,
          endTime: int.tryParse(endTimeController.text) ?? 0,
          imagePath: _selectedImage?.path ?? "",
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể lấy vị trí từ địa chỉ: $e')),
      );
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
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
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
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đăng ký thành công')),
              );
              Navigator.pop(context); // quay về login
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Lỗi: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Padding(
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

                    _buildImagePicker(),
                    const SizedBox(height: 20),

                    CustomTextField(controller: usernameController, hintText: "Username"),
                    const SizedBox(height: 16),
                    CustomTextField(controller: passwordController, hintText: "Password", isPassword: true),
                    const SizedBox(height: 16),
                    CustomTextField(controller: nameController, hintText: "Tên cửa hàng"),
                    const SizedBox(height: 16),
                    CustomTextField(controller: addressController, hintText: "Địa chỉ"),
                    const SizedBox(height: 16),
                    CustomTextField(controller: phoneController, hintText: "Số điện thoại"),
                    const SizedBox(height: 16),
                    CustomTextField(controller: nationController, hintText: "Quốc gia"),
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
                      title: isLoading ? "Đang xử lý..." : "Đăng ký",
                      onPressed: _submitForm,
                      height: 50,
                    ),
                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Quay lại đăng nhập", style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



