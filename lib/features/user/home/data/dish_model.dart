import 'dart:convert';

class DishInfo {
  final String name;
  final String image;
  final String description;

  DishInfo({
    required this.name,
    required this.image,
    required this.description,
  });

  factory DishInfo.fromJson(Map<String, dynamic> json) => DishInfo(
    name: json['name'] ?? '',
    image: json['image'] ?? '',
    description: json['description'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    'description': description,
  };
}

class PriceInfo {
  final double cost;
  final double discount;

  PriceInfo({
    required this.cost,
    required this.discount,
  });

  factory PriceInfo.fromJson(Map<String, dynamic> json) => PriceInfo(
    cost: (json['cost'] as num).toDouble(),
    discount: (json['discount'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'cost': cost,
    'discount': discount,
  };
}

class SearchInfo {
  final List<String> category;
  final String nation;

  SearchInfo({
    required this.category,
    required this.nation,
  });

  factory SearchInfo.fromJson(Map<String, dynamic> json) => SearchInfo(
    category: List<String>.from(json['category'] ?? []),
    nation: json['nation'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'category': category,
    'nation': nation,
  };
}

class TrendingDish {
  final String id;
  final String restaurantId;
  final DishInfo dish;
  final PriceInfo price;
  final int quantity;
  final SearchInfo search;

  TrendingDish({
    required this.id,
    required this.restaurantId,
    required this.dish,
    required this.price,
    required this.quantity,
    required this.search,
  });

  factory TrendingDish.fromJson(Map<String, dynamic> json) {
    return TrendingDish(
      id: json['id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      dish: DishInfo.fromJson(json['dish']),
      price: PriceInfo.fromJson(json['price']),
      quantity: json['quantity'] ?? 0,
      search: SearchInfo.fromJson(json['search']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'restaurantId': restaurantId,
    'dish': dish.toJson(),
    'price': price.toJson(),
    'quantity': quantity,
    'search': search.toJson(),
  };

  /// Optional: create list from top-level "items" JSON
  static List<TrendingDish> fromItemListJson(String jsonStr) {
    final decoded = jsonDecode(jsonStr);
    final List<dynamic> items = decoded['items'] ?? [];
    return items.map((e) => TrendingDish.fromJson(e)).toList();
  }

  /// Optional: convert list to {"items": [...]}
  static String toItemListJson(List<TrendingDish> dishes) {
    final List<Map<String, dynamic>> jsonList = dishes.map((e) => e.toJson()).toList();
    return jsonEncode({'items': jsonList});
  }
}
