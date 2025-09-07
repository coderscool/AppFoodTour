class Dish {
  final String name;
  final String image;
  final String description;

  Dish({
    required this.name,
    required this.image,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    'description': description,
  };
}

class Price {
  final int cost;
  final int discount;

  Price({
    required this.cost,
    required this.discount,
  });

  Map<String, dynamic> toJson() => {
    'cost': cost,
    'discount': discount,
  };
}

class CartItem {
  final String restaurantId;
  final String dishId;
  final List<String> extra;
  final Dish dish;
  final Price price;
  final int quantity;
  final String note;

  CartItem({
    required this.restaurantId,
    required this.dishId,
    required this.extra,
    required this.dish,
    required this.price,
    required this.quantity,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
    'restaurantId': restaurantId,
    'dishId': dishId,
    'extra': extra,
    'dish': dish.toJson(),
    'price': price.toJson(),
    'quantity': quantity,
    'note': note,
  };
}

class AddCartRequest {
  final String cartId;
  final CartItem item;

  AddCartRequest({
    required this.cartId,
    required this.item,
  });

  Map<String, dynamic> toJson() => {
    'cartId': cartId,
    'item': item.toJson(),
  };
}
