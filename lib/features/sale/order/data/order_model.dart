class OrderResponse {
  final List<OrderGroup> items;

  OrderResponse({required this.items});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      items: (json['items'] as List)
          .map((e) => OrderGroup.fromJson(e))
          .toList(),
    );
  }
}

class OrderGroup {
  final String groupId;
  final String orderId;
  final List<OrderItem> items;
  final String status;
  final DateTime createdAt;

  OrderGroup({
    required this.groupId,
    required this.orderId,
    required this.items,
    required this.status,
    required this.createdAt,
  });

  factory OrderGroup.fromJson(Map<String, dynamic> json) {
    return OrderGroup(
      groupId: json['groupId'],
      orderId: json['orderId'],
      items: (json['items'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      status: json['status'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (json['createdAt']['seconds'] * 1000).toInt(),
      ),
    );
  }
}

class OrderItem {
  final String itemId;
  final String dishId;
  final Dish dish;
  final int quantity;
  final String note;
  final Price price;

  OrderItem({
    required this.itemId,
    required this.dishId,
    required this.dish,
    required this.quantity,
    required this.note,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemId: json['itemId'],
      dishId: json['dishId'],
      dish: Dish.fromJson(json['dish']),
      quantity: json['quantity'],
      note: json['note'],
      price: Price.fromJson(json['price']),
    );
  }
}

class Dish {
  final String name;
  final String image;
  final String description;

  Dish({
    required this.name,
    required this.image,
    required this.description,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      name: json['name'],
      image: json['image'],
      description: json['description'],
    );
  }
}

class Price {
  final int cost;
  final int discount;

  Price({required this.cost, required this.discount});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      cost: json['cost'],
      discount: json['discount'],
    );
  }
}
