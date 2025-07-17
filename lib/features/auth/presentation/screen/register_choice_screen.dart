import 'package:appfoodtour/features/auth/presentation/screen/register_seller_screen.dart';
import 'package:appfoodtour/features/auth/presentation/screen/register_shipper_screen.dart';
import 'package:appfoodtour/features/auth/presentation/screen/register_user_screen.dart';
import 'package:flutter/material.dart';

class RegisterChoiceScreen extends StatelessWidget {
  const RegisterChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chọn loại đăng ký')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChoiceButton(
              context,
              label: 'Đăng ký người dùng',
              screen: const UserRegisterScreen(),
            ),
            const SizedBox(height: 16),
            _buildChoiceButton(
              context,
              label: 'Đăng ký người bán',
              screen: const SellerRegisterScreen(),
            ),
            const SizedBox(height: 16),
            _buildChoiceButton(
              context,
              label: 'Đăng ký người giao hàng',
              screen: const ShipperRegisterScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceButton(BuildContext context,
      {required String label, required Widget screen}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
        child: Text(label),
      ),
    );
  }
}
