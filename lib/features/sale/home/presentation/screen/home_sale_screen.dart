import 'package:appfoodtour/features/sale/createdish/presentation/screen/add_dish_screen.dart';
import 'package:appfoodtour/features/sale/order/presentation/screen/order_screen.dart';
import 'package:flutter/material.dart';

class HomeSaleScreen extends StatelessWidget {
  const HomeSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dishes = <Map<String, dynamic>>[
      {
        'name': 'Bún bò Huế',
        'price': 45000,
        'description': 'Đặc sản miền Trung đậm đà hương vị.',
      },
      {
        'name': 'Phở bò tái',
        'price': 50000,
        'description': 'Phở truyền thống với nước dùng thơm ngon.',
      },
      {
        'name': 'Cơm tấm sườn bì',
        'price': 55000,
        'description': 'Món ăn đặc trưng Sài Gòn.',
      },
    ];

    final List<Map<String, dynamic>> stats = <Map<String, dynamic>>[
      {'icon': Icons.monetization_on, 'title': 'Doanh thu', 'value': '25.000.000₫'},
      {'icon': Icons.shopping_cart, 'title': 'Đơn hàng', 'value': '520'},
      {'icon': Icons.fastfood, 'title': 'Món ăn', 'value': '18'},
      {'icon': Icons.people, 'title': 'Khách hàng', 'value': '230'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Quản lý quán ăn', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Tổng quan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(
              children: [
                for (int i = 0; i < stats.length; i++) ...<Widget>[
                  StatCard(
                    icon: stats[i]['icon']! as IconData,
                    title: stats[i]['title']! as String,
                    value: stats[i]['value']! as String,
                  ),
                  if (i < stats.length - 1) const SizedBox(height: 12),
                ],
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Danh sách món ăn',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrderScreen()),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.deepOrange),
                  tooltip: 'Thêm món ăn',
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...dishes.map<Widget>((Map<String, dynamic> dish) => DishCard(dish: dish)).toList(),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 2))
        ],
      ),
      padding: const EdgeInsets.all(12),
      height: 100,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            radius: 24,
            child: Icon(icon, color: Colors.deepOrange, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

class DishCard extends StatelessWidget {
  final Map<String, dynamic> dish;

  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.fastfood, size: 30, color: Colors.deepOrange),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    dish['name']! as String,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    dish['description']! as String,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${dish['price']!}₫',
                        style: const TextStyle(color: Colors.black87),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red, size: 20.0),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.info, color: Colors.blue, size: 20.0),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.deepOrange, size: 20.0),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
