// data/models/trending_dish_model.dart
import '../../domain/entities/dish.dart';

class DishModel extends Dish {
  DishModel({
    required super.name,
    required super.image,
    required super.description,
    required super.cost,
    required super.discount,
    required super.quantity,
    required super.extras,
    required super.categories,
    required super.nation,
  });

  Map<String, dynamic> toJson() => {
    "dish": {
      "name": name,
      "image": image,
      "description": description,
    },
    "extra": extras
        .map((e) => {"name": e.name, "price": e.price})
        .toList(),
    "price": {"cost": cost, "discount": discount},
    "quantity": quantity,
    "search": {
      "nation": nation,
      "category": categories,
    },
  };
}
