import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<CartScreen> {
  // Define constants for quantity button sizing
  static const double _quantityButtonSize = 20.0;
  static const double _quantityIconSize = 12.0;

  List<CartItem> cartItems = <CartItem>[
    CartItem(
        name: "Pizza hải sản",
        price: 59000,
        quantity: 1,
        imageUrl: "https://i.imgur.com/xdbHo4E.png"),
    CartItem(
        name: "Burger bò",
        price: 49000,
        quantity: 2,
        imageUrl: "https://i.imgur.com/OPkErhJ.png"),
    CartItem(
        name: "Gà rán giòn",
        price: 65000,
        quantity: 1,
        imageUrl: "https://i.imgur.com/Iq8wC7p.png"),
  ];

  int get totalPrice => cartItems
      .where((CartItem item) => item.isSelected)
      .fold(0, (int sum, CartItem item) => sum + item.price * item.quantity);

  bool get hasSelectedItems => cartItems.any((CartItem item) => item.isSelected);

  void toggleSelection(int index) {
    setState(() {
      cartItems[index].isSelected = !cartItems[index].isSelected;
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  String formatCurrency(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Giỏ hàng")),
      body: ListView.builder(
        itemCount: cartItems.length,
        padding: EdgeInsets.only(bottom: hasSelectedItems ? 120 : 20),
        itemBuilder: (BuildContext context, int index) {
          final CartItem item = cartItems[index];
          return Stack(
            children: <Widget>[
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              item.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                      fontSize: 12, // Adjusted from 10
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Không hành, ít sốt",
                                  style: TextStyle(fontSize: 8), // Adjusted from 8
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      formatCurrency(item.price),
                                      style: const TextStyle(
                                          fontSize: 12, // Adjusted from 10
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _QuantityButton(
                                          icon: Icons.remove,
                                          onPressed: () => decreaseQuantity(index),
                                          buttonSize: _quantityButtonSize,
                                          iconSize: _quantityIconSize,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(
                                            "${item.quantity}",
                                            style: const TextStyle(fontSize: 12), // Adjusted from 10
                                          ),
                                        ),
                                        _QuantityButton(
                                          icon: Icons.add,
                                          onPressed: () => increaseQuantity(index),
                                          buttonSize: _quantityButtonSize,
                                          iconSize: _quantityIconSize,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 10,
                child: Transform.scale(
                    scale: 0.75,
                    child: Checkbox(
                      value: item.isSelected,
                      onChanged: (bool? value) => toggleSelection(index),
                    )
                ),
              ),
            ],
          );
        },
      ),
      bottomSheet: hasSelectedItems
          ? Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Tổng tiền:", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
                Text(formatCurrency(totalPrice),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange)),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              ),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext dialogContext) => AlertDialog(
                    title: const Text("Xác nhận thanh toán"),
                    content: Text(
                        "Bạn có muốn thanh toán ${formatCurrency(totalPrice)} không?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text("Hủy"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: const Text("Thanh toán"),
                      ),
                    ],
                  ),
                );
              },
              child:
              const Text("Thanh toán", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      )
          : null,
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.onPressed,
    required this.buttonSize,
    required this.iconSize,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double buttonSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final bool isAdd = icon == Icons.add;

    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: isAdd ? Colors.orange : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isAdd ? Colors.orange : Colors.orange, // cùng màu để đồng bộ
          width: 1.2,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: isAdd ? Colors.white : Colors.orange,
          ),
        ),
      ),
    );
  }
}

class CartItem {
  String name;
  int price;
  int quantity;
  bool isSelected;
  String imageUrl;

  CartItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    this.isSelected = false,
  });
}
