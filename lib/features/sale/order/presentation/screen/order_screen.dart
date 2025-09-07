import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<List<OrderGroup>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders();
  }

  Future<List<OrderGroup>> fetchOrders() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:7275/api/order/seller?Id=686f30e7e5479c74cd793576&Limit=5&Offset=0"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final items = data['items'] as List;
      return items.map((e) => OrderGroup.fromJson(e)).toList();
    } else {
      throw Exception("Lỗi khi tải đơn hàng");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Danh sách đơn hàng")),
      body: FutureBuilder<List<OrderGroup>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text("Đơn hàng #${order.orderId}"),
                  subtitle: Text("Trạng thái: ${order.status}"),
                  children: order.items.map((item) {
                    return ListTile(
                      leading: Image.network(item.dish.image, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(item.dish.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("SL: ${item.quantity} | Ghi chú: ${item.note}"),
                          Text("Giá: ${item.price.cost}đ"),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
