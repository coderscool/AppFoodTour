// domain/entities/trending_dish.dart
class Dish {
  final String name;
  final String image;
  final String description;
  final double cost;
  final double discount;
  final int quantity;
  final List<Extra> extras;
  final List<String> categories;
  final String nation;

  Dish({
    required this.name,
    required this.image,
    required this.description,
    required this.cost,
    required this.discount,
    required this.quantity,
    required this.extras,
    required this.categories,
    required this.nation,
  });
}

class Extra {
  final String name;
  final double price;

  Extra({required this.name, required this.price});
}
