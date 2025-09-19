import 'package:flutter/material.dart';
import '../../domain/entities/stat.dart';

class StatCard extends StatelessWidget {
  final Stat stat;

  const StatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, offset: const Offset(0, 2))
        ],
      ),
      padding: const EdgeInsets.all(12),
      height: 100,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            radius: 24,
            child: Icon(stat.icon, color: Colors.deepOrange, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(stat.title, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 4),
              Text(stat.value,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
