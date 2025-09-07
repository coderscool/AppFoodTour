import 'package:flutter/material.dart';
import 'custom_text_field.dart';
import 'primary_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      // TODO: gọi Bloc/Provider để login
      debugPrint("Login with: ${_emailController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _emailController,
            hintText: "Email or Phone Number",
            validator: (value) =>
            (value == null || value.isEmpty) ? "Please enter email/phone" : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            hintText: "Password",
            isPassword: true, // 👈 thêm toggle mật khẩu
            validator: (value) {
              if (value == null || value.isEmpty) return "Please enter password";
              if (value.length < 6) return "Password must be at least 6 characters";
              return null;
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 8),
          PrimaryButton(
            title: "Login",
            onPressed: _onLoginPressed,
          ),
        ],
      ),
    );
  }
}
