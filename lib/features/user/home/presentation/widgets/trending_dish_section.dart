import 'package:flutter/material.dart';
import '../../domain/entities/trending_dish.dart';
import './trending_dish_card.dart';

class TrendingDishesSection extends StatelessWidget {
  final List<TrendingDish> trendingDishes;

  const TrendingDishesSection({required this.trendingDishes});

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
                    final Widget dishCard = TrendingDishCard(
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