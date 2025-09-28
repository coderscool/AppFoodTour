import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/dish.dart';
import '../widgets/dish_detail_content.dart';
import '../widgets/bottom_action_bar.dart';

class DishDetailScreen extends StatefulWidget {
  final String id;
  final String storeId;

  const DishDetailScreen({super.key, required this.id, required this.storeId});

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  int quantity = 1;
  late Dish dish;

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
            padding: const EdgeInsets.only(bottom: 40),
            child: DishDetailContent(
              dish: dish,
              basePrice: basePrice,
              currencyFormatter: currencyFormatter,
              extraOptions: extraOptions,
              onExtraChanged: (key, value) {
                setState(() {
                  extraOptions[key] = value;
                });
              },
            ),
          ),
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
              child: BottomActionBar(
                quantity: quantity,
                totalPrice: calculateTotal(),
                onDecrease: () {
                  if (quantity > 1) setState(() => quantity--);
                },
                onIncrease: () => setState(() => quantity++),
                onAddToCart: () {
                  // TODO: xử lý thêm vào giỏ
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

