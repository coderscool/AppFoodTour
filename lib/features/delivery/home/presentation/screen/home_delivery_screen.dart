import 'package:flutter/material.dart';

class HomeDeliveryScreen extends StatelessWidget {
  const HomeDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang Giao hàng')),
      body: const Center(child: Text('Bạn đang ở giao diện shipper')),
    );
  }
}