import 'package:flutter/material.dart';
import '../screen/signup_role_screen.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don’t have an account? "),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SignUpRoleScreen(),
              ),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
