import '../../domain/entities/trending_dish.dart';

class TrendingDishModel extends TrendingDish {
  TrendingDishModel({required super.id, required super.restaurantId, required super.name,
    required super.image, required super.description, required super.quantity, required super.price});

  factory TrendingDishModel.fromJson(Map<String, dynamic> json) {
    return TrendingDishModel(
      id: json['id'],
      restaurantId: json['restaurantId'],
      name: json['dish']['name'],
      image: json['dish']['image'],
      description: json['dish']['description'],
      quantity: json['quantity'],
      price: json['price']
    );
  }
}

