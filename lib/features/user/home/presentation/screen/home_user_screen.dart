import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../dish/presentation/screen/dish_detail_screen.dart';
import '../../data/dish_model.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeUserScreen> {
  final List<String> bannerUrls = [
    'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
  ];

  List<TrendingDish> trendingDishes = [];
  bool isLoading = true;

  int currentPageIndex = 0;

  void onBannerPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTrendingDishes();
  }

  Future<void> fetchTrendingDishes() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:7275/api/dish/trending'));

      if (response.statusCode == 200) {
        setState(() {
          trendingDishes = TrendingDish.fromItemListJson(response.body);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Text(
                    'foodtour',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFE65100),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.search, color: Colors.black87),
                  SizedBox(width: 8),
                  Icon(Icons.notifications, color: Colors.black87),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Text(
                    'Explore',
                    style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Offers',
                    style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 1.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.grey.withOpacity(0.0),
                    Colors.grey.shade400,
                    Colors.grey.withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            _SwipableAdvertisementBanner(
              bannerUrls: bannerUrls,
              currentPageIndex: currentPageIndex,
              onPageChanged: onBannerPageChanged,
            ),
            isLoading
                ? const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: CircularProgressIndicator()),
            )
                : _TrendingDishesSection(trendingDishes: trendingDishes),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Center(
                child: Text(
                  'More delicious content here!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwipableAdvertisementBanner extends StatelessWidget {
  final List<String> bannerUrls;
  final int currentPageIndex;
  final Function(int) onPageChanged;

  const _SwipableAdvertisementBanner({
    required this.bannerUrls,
    required this.currentPageIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: SizedBox(
              height: 120,
              child: PageView.builder(
                itemCount: bannerUrls.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return _BannerPage(imageUrl: bannerUrls[index]);
                },
              ),
            ),
          ),
          if (bannerUrls.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bannerUrls.asMap().entries.map<Widget>((entry) {
                  final int index = entry.key;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8.0,
                    width: currentPageIndex == index ? 24.0 : 8.0,
                    decoration: BoxDecoration(
                      color: currentPageIndex == index
                          ? const Color(0xFFE65100)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _BannerPage extends StatelessWidget {
  final String imageUrl;

  const _BannerPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 120,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 120,
            color: Colors.grey.shade200,
            child: const Center(
              child: Icon(Icons.broken_image, color: Colors.grey, size: 48),
            ),
          );
        },
      ),
    );
  }
}

class _TrendingDishesSection extends StatelessWidget {
  final List<TrendingDish> trendingDishes;

  const _TrendingDishesSection({required this.trendingDishes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Trending Dishes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double sectionAvailableWidth = constraints.maxWidth;
              final double cardWidth = (sectionAvailableWidth - 16.0) / 2;

              return SizedBox(
                height: cardWidth + 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingDishes.length,
                  itemBuilder: (context, index) {
                    final Widget dishCard = _TrendingDishCard(
                      dish: trendingDishes[index],
                      cardWidth: cardWidth,
                    );
                    if (index < trendingDishes.length - 1) {
                      return Row(
                        children: <Widget>[
                          dishCard,
                          const SizedBox(width: 16.0),
                        ],
                      );
                    } else {
                      return dishCard;
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TrendingDishCard extends StatelessWidget {
  final TrendingDish dish;
  final double cardWidth;

  const _TrendingDishCard({required this.dish, required this.cardWidth});

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormatter = NumberFormat("#,##0", "vi_VN");
    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12.0),
              bottom: Radius.circular(12.0),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                dish.dish.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey, size: 48),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DishDetailScreen(id: dish.id, storeId: dish.restaurantId),
                      ),
                    );
                  },
                  child: Text(
                    dish.dish.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue, // Optional: để người dùng biết có thể nhấn
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star_rate_rounded,
                      color: Color(0xFFFB8C00),
                      size: 16,
                    ),
                    Text(
                      '4',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '(120 reviews)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${currencyFormatter.format(dish.price.cost)} đ',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Đã thêm ${dish.dish.name} vào giỏ')),
                      );
                    },
                    child: const Text(
                      'Thêm món',
                      style: TextStyle(fontSize: 12, color: Colors.white),
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



