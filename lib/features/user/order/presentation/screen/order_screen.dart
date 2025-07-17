import 'package:appfoodtour/features/user/order/presentation/screen/order_detail_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  final List<OrderItem> orders = const [
    OrderItem(
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/3595/3595455.png',
      name: 'Cơm gà xối mỡ',
      quantity: 1,
      price: 45000,
      status: 'Đang chuẩn bị',
      orderTime: '2025-06-28 11:23',
      orderId: 'OD123456',
    ),
    OrderItem(
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/3595/3595455.png',
      name: 'Bún bò Huế đặc biệt siêu cay cấp độ 5',
      quantity: 2,
      price: 90000,
      status: 'Đang giao',
      orderTime: '2025-06-28 10:45',
      orderId: 'OD123457',
    ),
    OrderItem(
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/3595/3595455.png',
      name: 'Trà sữa trân châu đường đen',
      quantity: 1,
      price: 30000,
      status: 'Đã giao',
      orderTime: '2025-06-27 18:20',
      orderId: 'OD123458',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Theo dõi đơn hàng'),
        backgroundColor: Colors.orange.shade600,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return OrderCard(order: order);
        },
      ),
    );
  }
}

class OrderItem {
  final String imageUrl;
  final String name;
  final int quantity;
  final int price;
  final String status;
  final String orderTime;
  final String orderId;

  const OrderItem({
    required this.imageUrl,
    required this.name,
    required this.quantity,
    required this.price,
    required this.status,
    required this.orderTime,
    required this.orderId,
  });
}

class OrderCard extends StatelessWidget {
  final OrderItem order;
  const OrderCard({super.key, required this.order});

  Color getStatusColor(String status) {
    switch (status) {
      case 'Đang chuẩn bị':
        return Colors.orange;
      case 'Đang giao':
        return Colors.blue;
      case 'Đã giao':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat("#,##0", "vi_VN");
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(order.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('SL: ${order.quantity}   ', style: const TextStyle(fontSize: 13)),
                    Text('Giá: ${currencyFormatter.format(order.price)}đ',
                        style: const TextStyle(fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 2),
                Text('Mã: ${order.orderId}', style: const TextStyle(fontSize: 12)),
                Text('Thời gian: ${order.orderTime}', style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderTrackingDetailScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Xem chi tiết',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.orange.shade700,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getStatusColor(order.status).withOpacity(0.1),
                    border: Border.all(color: getStatusColor(order.status)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      fontSize: 12,
                      color: getStatusColor(order.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
