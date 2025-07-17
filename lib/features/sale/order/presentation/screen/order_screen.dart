import 'package:flutter/material.dart';

class OrderManageScreen extends StatefulWidget {
  const OrderManageScreen({super.key});

  @override
  State<OrderManageScreen> createState() => _OrderManageScreenState();
}

class _OrderManageScreenState extends State<OrderManageScreen> {
  List<Map<String, dynamic>> orders = [
    {
      "id": "1",
      "customerName": "Nguyễn Văn A",
      "address": "123 Lê Lợi, Q1",
      "total": 150000,
      "status": "pending",
    },
    {
      "id": "2",
      "customerName": "Trần Thị B",
      "address": "456 Hai Bà Trưng, Q3",
      "total": 200000,
      "status": "preparing",
    },
  ];

  void updateOrderStatus(String id, String newStatus) {
    setState(() {
      final index = orders.indexWhere((order) => order['id'] == id);
      if (index != -1) {
        orders[index]['status'] = newStatus;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cập nhật đơn hàng $id → $newStatus')),
    );
  }

  Widget _buildActions(Map<String, dynamic> order) {
    switch (order['status']) {
      case 'pending':
        return Row(
          children: [
            ElevatedButton(
              onPressed: () =>
                  updateOrderStatus(order['id'], 'preparing'),
              child: const Text('Chấp nhận'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => updateOrderStatus(order['id'], 'rejected'),
              child: const Text('Huỷ'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      case 'preparing':
        return ElevatedButton(
          onPressed: () => updateOrderStatus(order['id'], 'done'),
          child: const Text('Hoàn thành chuẩn bị'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
        );
      case 'done':
        return const Text('✅ Đã hoàn thành',
            style: TextStyle(color: Colors.green));
      case 'rejected':
        return const Text('❌ Đã huỷ',
            style: TextStyle(color: Colors.red));
      default:
        return const SizedBox.shrink();
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.blueGrey;
      case 'preparing':
        return Colors.orange;
      case 'done':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý đơn hàng')),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Khách: ${order['customerName']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("Địa chỉ: ${order['address']}"),
                  Text("Tổng tiền: ${order['total']}đ"),
                  const SizedBox(height: 8),
                  Text(
                    "Trạng thái: ${order['status'].toUpperCase()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _statusColor(order['status']),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActions(order),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
