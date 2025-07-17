import 'package:appfoodtour/features/auth/presentation/screen/login_screen.dart';
import 'package:appfoodtour/features/services/local_storage_service.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _role;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadLoginStatus();
  }

  Future<void> _loadLoginStatus() async {
    final isLoggedIn = LocalStorageService.isLoggedIn();
    final role = LocalStorageService.getUserRole();

    setState(() {
      _isLoggedIn = isLoggedIn as bool;
      _role = role as String;
    });
  }

  void _goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ người dùng')),
      body: Center(
        child: _isLoggedIn
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bạn đã đăng nhập với vai trò:'),
            const SizedBox(height: 8),
            Text(
              _role ?? 'Không rõ',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        )
            : ElevatedButton(
          onPressed: _goToLogin,
          child: const Text('Đăng nhập ngay'),
        ),
      ),
    );
  }
}
