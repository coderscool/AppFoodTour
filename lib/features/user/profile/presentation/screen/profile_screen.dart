import 'package:appfoodtour/features/auth/presentation/screen/login_screen.dart';
import 'package:appfoodtour/features/services/local_storage_service.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _loginStatusFuture;

  @override
  void initState() {
    super.initState();
    _loginStatusFuture = _getLoginStatus();
  }

  Future<Map<String, dynamic>> _getLoginStatus() async {
    final isLoggedIn = await LocalStorageService.isLoggedIn();
    final role = await LocalStorageService.getUserRole();
    return {
      'isLoggedIn': isLoggedIn,
      'role': role,
    };
  }

  void _goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    ).then((_) {
      setState(() {
        _loginStatusFuture = _getLoginStatus();
      });
    });
  }

  Future<void> _logout() async {
    await LocalStorageService.clearLoginInfo();
    setState(() {
      _loginStatusFuture = _getLoginStatus(); // cập nhật lại UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ người dùng')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loginStatusFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final isLoggedIn = snapshot.data!['isLoggedIn'] as bool;
          final role = snapshot.data!['role'] as String;

          return Center(
            child: isLoggedIn
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Bạn đã đăng nhập với vai trò:'),
                const SizedBox(height: 8),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Đăng xuất'),
                )
              ],
            )
                : ElevatedButton(
              onPressed: _goToLogin,
              child: const Text('Đăng nhập ngay'),
            ),
          );
        },
      ),
    );
  }
}

