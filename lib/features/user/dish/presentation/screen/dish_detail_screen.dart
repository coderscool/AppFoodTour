import 'dart:convert';

import 'package:appfoodtour/features/user/home/data/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class UserReview {
  final String name;
  final String avatarUrl;
  final double rating;
  final String comment;

  UserReview({
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.comment,
  });
}

class DishDetailScreen extends StatefulWidget {
  final String id;
  final String storeId;
  const DishDetailScreen({required this.id, required this.storeId});

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  int quantity = 1;

  late TrendingDish dish;

  final int basePrice = 4900000;

  final currencyFormatter = NumberFormat("#,##0", "vi_VN");

  Map<String, bool> extraOptions = {
    "Thêm trứng (+5k)": false,
    "Thêm chả (+7k)": false,
    "Thêm rau sống (+3k)": false,
  };

  Map<String, int> extraPrices = {
    "Thêm trứng (+5k)": 5000,
    "Thêm chả (+7k)": 7000,
    "Thêm rau sống (+3k)": 3000,
  };

  List<UserReview> reviews = [];

  double userRating = 5;
  final TextEditingController commentController = TextEditingController();
  bool showActionButtons = false;

  bool isLoading = true;

  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchTrendingDishes(widget.id);

    commentController.addListener(() {
      final hasText = commentController.text.trim().isNotEmpty;
      if (showActionButtons != hasText) {
        setState(() {
          showActionButtons = hasText;
        });
      }
    });
  }

  Future<void> fetchTrendingDishes(String id) async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:7275/api/dish/detail?id=$id'));

      if (response.statusCode == 200) {
        setState(() {
          final Map<String, dynamic> data = jsonDecode(response.body);
          dish = TrendingDish.fromJson(jsonDecode(response.body));
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load dishes');
      }
    } catch (e) {
      debugPrint('Error: $e');
      setState(() => isLoading = false);
    }
  }

  int calculateTotal() {
    int extra = 0;
    extraOptions.forEach((key, selected) {
      if (selected) extra += extraPrices[key] ?? 0;
    });
    return (basePrice + extra) * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40), // để chừa nút ở dưới
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Ảnh
                SizedBox(
                  height: 260,
                  width: double.infinity,
                  child: Image.network(
                    dish.dish.image,
                    fit: BoxFit.cover,
                  ),
                ),

                /// Nội dung
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: _buildFoodDetail(context),
                ),
              ],
            ),
          ),

          /// Nút Back
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.black45,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    /// Tổng tiền
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Tổng tiền",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            "${currencyFormatter.format(calculateTotal())} đ",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Tăng giảm số lượng
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          _buildSmallIconButton(Icons.remove, () {
                            if (quantity > 1) setState(() => quantity--);
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          _buildSmallIconButton(Icons.add, () {
                            setState(() => quantity++);
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// Nút thêm vào giỏ
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        // TODO: xử lý thêm vào giỏ
                      },
                      child: const Text(
                        "Thêm vào giỏ",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodDetail(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dish.dish.name,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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

        const SizedBox(height: 12),

        Row(
          children: const [
            Icon(Icons.star, size: 18, color: Colors.amber),
            Icon(Icons.star, size: 18, color: Colors.amber),
            Icon(Icons.star, size: 18, color: Colors.amber),
            Icon(Icons.star_half, size: 18, color: Colors.amber),
            Icon(Icons.star_border, size: 18, color: Colors.amber),
            SizedBox(width: 6),
            Text("(123 đánh giá)", style: TextStyle(fontSize: 14)),
          ],
        ),

        const SizedBox(height: 16),

        const Text(
          "Món cơm gà chiên xối mỡ giòn rụm, đậm đà hương vị. Phục vụ kèm rau sống và nước mắm đặc biệt.",
          style: TextStyle(fontSize: 15, height: 1.5),
        ),

        const SizedBox(height: 20),

        const Text(
          "Chọn thêm nguyên liệu kèm:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        ...extraOptions.keys.map((key) {
          return CheckboxListTile(
            title: Text(key),
            value: extraOptions[key],
            activeColor: Colors.deepOrange,
            contentPadding: EdgeInsets.zero,
            onChanged: (bool? value) {
              setState(() {
                extraOptions[key] = value ?? false;
              });
            },
          );
        }).toList(),
        const SizedBox(height: 24),
        const Text(
          "Đánh giá món ăn:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        /// Rating bar (từ 1 đến 5 sao)
        Row(
          children: const [
            Icon(Icons.star, size: 18, color: Colors.amber),
            Icon(Icons.star, size: 18, color: Colors.amber),
            Icon(Icons.star, size: 18, color: Colors.amber),
            Icon(Icons.star_half, size: 18, color: Colors.amber),
            Icon(Icons.star_border, size: 18, color: Colors.amber),
          ],
        ),

        const SizedBox(height: 12),

        /// Ô nhập nội dung đánh giá
        TextField(
          controller: commentController,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "Viết đánh giá của bạn...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(12),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
            ),
          ),
        ),

        // Nút gửi / huỷ — chỉ hiển thị khi có nội dung
        if (showActionButtons)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Nút Huỷ
                TextButton(
                  onPressed: () {
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                    setState(() {
                      showActionButtons = false;
                    });
                  },
                  child: const Text(
                    "Huỷ",
                    style: TextStyle(color: Colors.black),
                  ),
                ),

                const SizedBox(width: 8),

                // Nút Gửi
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Gửi đánh giá
                    print("⭐ $userRating\n💬 ${commentController.text}");

                    // Reset
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                    setState(() {
                      userRating = 5;
                      showActionButtons = false;
                    });
                  },
                  label: const Text(
                    "Gửi",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (reviews.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Text(
            "Đánh giá từ người dùng:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
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
                    /// Ảnh đại diện
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(review.avatarUrl),
                    ),
                    const SizedBox(width: 12),

                    /// Nội dung
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),

                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < review.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 18,
                                color: Colors.amber,
                              );
                            }),
                          ),
                          const SizedBox(height: 6),

                          Text(
                            review.comment,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildSmallIconButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 20, // Tổng size container ~ 16px icon + padding
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepOrange,
        ),
        child: Icon(icon, size: 12, color: Colors.white),
      ),
    );
  }
}
