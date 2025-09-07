import 'package:flutter/material.dart';

class RoleButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const RoleButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
