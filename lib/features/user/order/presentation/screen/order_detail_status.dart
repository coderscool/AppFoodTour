import 'package:appfoodtour/features/user/order/presentation/screen/map_screen.dart';
import 'package:flutter/material.dart';

class OrderTrackingDetailScreen extends StatelessWidget {
  const OrderTrackingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Status'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Mã đơn
            const Text(
              "INVOICE : 12A394",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Ảnh món ăn
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/3595/3595455.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 20),

            // Trạng thái đơn hàng
            Expanded(
              child: ListView(
                children: const [
                  OrderStepItem(
                    isActive: true,
                    title: "Order received",
                    time: "08:30 AM, 9 May 2019",
                  ),
                  OrderStepItem(
                    isActive: true,
                    title: "On the way",
                    time: "09:15 AM, 9 May 2019",
                    showTracking: true,
                  ),
                  OrderStepItem(
                    isActive: false,
                    title: "Delivered",
                    time: "Finish time in 3 min",
                  ),
                ],
              ),
            ),

            // Nút xác nhận
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Confirm Delivery",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class OrderStepItem extends StatelessWidget {
  final bool isActive;
  final String title;
  final String time;
  final bool showTracking;

  const OrderStepItem({
    super.key,
    required this.isActive,
    required this.title,
    required this.time,
    this.showTracking = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.blueAccent : Colors.grey.shade300;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Line & dot
        Column(
          children: [
            Container(
              width: 20,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 60,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),

        // Nội dung
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: isActive ? Colors.black : Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
              if (showTracking)
                GestureDetector(
                  onTap: () {
                    // 👉 Chuyển sang màn hình theo dõi đơn hàng chi tiết
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MapScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "TRACKING",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
