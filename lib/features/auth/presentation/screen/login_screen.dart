import 'package:appfoodtour/features/auth/data/auth_service.dart';
import 'package:appfoodtour/features/auth/presentation/screen/register_choice_screen.dart';
import 'package:appfoodtour/features/sale/home/presentation/screen/home_sale_screen.dart';
import 'package:appfoodtour/features/user/footer/presentation/screen/footer_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _handleLogin() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final role = await AuthService.login(
      usernameController.text,
      passwordController.text,
    );

    setState(() => _loading = false);

    if (role != null) {
      if(role == "user"){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const FooterScreen()),
              (route) => false,
        );
      }
      if(role == "seller"){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeSaleScreen()),
              (route) => false,
        );
      };
    } else {
      setState(() => _error = 'Đăng nhập thất bại. Vui lòng kiểm tra lại.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
            ),
            const SizedBox(height: 24),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Đăng nhập'),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Chưa có tài khoản? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterChoiceScreen()),
                    );
                  },
                  child: const Text("Đăng ký"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
