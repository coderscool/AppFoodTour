import '../../domain/entities/dish.dart';

class DishModel extends Dish {
  DishModel({required super.name, required super.price, required super.description});

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }
}