import 'package:flutter/material.dart';

class BannerPage extends StatelessWidget {
  final String imageUrl;

  const BannerPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 120,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 120,
            color: Colors.grey.shade200,
            child: const Center(
              child: Icon(Icons.broken_image, color: Colors.grey, size: 48),
            ),
          );
        },
      ),
    );
  }
}