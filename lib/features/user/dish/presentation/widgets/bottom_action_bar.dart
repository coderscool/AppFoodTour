import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomActionBar extends StatelessWidget {
  final int quantity;
  final int totalPrice;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onAddToCart;

  const BottomActionBar({
    super.key,
    required this.quantity,
    required this.totalPrice,
    required this.onDecrease,
    required this.onIncrease,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat("#,##0", "vi_VN");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Tổng tiền", style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(
                  "${currencyFormatter.format(totalPrice)} đ",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                ),
              ],
            ),
          ),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _smallBtn(Icons.remove, onDecrease),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text('$quantity', style: const TextStyle(fontSize: 14)),
                ),
                _smallBtn(Icons.add, onIncrease),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: onAddToCart,
            child: const Text("Thêm vào giỏ", style: TextStyle(fontSize: 14, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _smallBtn(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.deepOrange),
        child: Icon(icon, size: 12, color: Colors.white),
      ),
    );
  }
}
