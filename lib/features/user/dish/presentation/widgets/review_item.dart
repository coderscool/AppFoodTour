import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final String avatarUrl;
  final double rating;
  final String comment;

  const ReviewItem({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundImage: NetworkImage(avatarUrl)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                        (i) => Icon(
                      i < rating ? Icons.star : Icons.star_border,
                      size: 18,
                      color: Colors.amber,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(comment, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
