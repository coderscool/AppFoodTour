import 'package:appfoodtour/features/auth/presentation/screen/seller_register_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/role_button.dart';

class SignUpRoleScreen extends StatelessWidget {
  const SignUpRoleScreen({super.key});

  void _onRoleSelected(BuildContext context, String role) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Selected role: $role")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Role"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Sign up as:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            RoleButton(
              title: "User",
              onPressed: () => _onRoleSelected(context, "User"),
            ),
            const SizedBox(height: 20),

            RoleButton(
              title: "Seller",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SellerRegisterScreen()),
                );
              },
            ),
            const SizedBox(height: 20),

            RoleButton(
              title: "Shipper",
              onPressed: () => _onRoleSelected(context, "Shipper"),
            ),
          ],
        ),
      ),
    );
  }
}

