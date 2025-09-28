import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/dish.dart';
import 'review_item.dart';

class DishDetailContent extends StatelessWidget {
  final Dish dish;
  final int basePrice;
  final NumberFormat currencyFormatter;
  final Map<String, bool> extraOptions;
  final Function(String, bool) onExtraChanged;

  const DishDetailContent({
    super.key,
    required this.dish,
    required this.basePrice,
    required this.currencyFormatter,
    required this.extraOptions,
    required this.onExtraChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Ảnh
        SizedBox(
          height: 260,
          width: double.infinity,
          child: Image.network(dish.image, fit: BoxFit.cover),
        ),

        /// Nội dung
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dish.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${currencyFormatter.format(basePrice)} đ",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              /// Extra option
              const Text(
                "Chọn thêm nguyên liệu kèm:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...extraOptions.keys.map(
                    (key) => CheckboxListTile(
                  title: Text(key),
                  value: extraOptions[key],
                  activeColor: Colors.deepOrange,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) => onExtraChanged(key, val ?? false),
                ),
              ),

              const SizedBox(height: 24),

              /// Ví dụ review item
              const Text(
                "Đánh giá từ người dùng:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const ReviewItem(
                name: "Nguyễn Văn A",
                avatarUrl: "https://i.pravatar.cc/100",
                rating: 4,
                comment: "Món ăn rất ngon, sẽ ủng hộ lần sau!",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

