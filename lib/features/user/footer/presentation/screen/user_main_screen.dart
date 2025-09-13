import 'package:appfoodtour/features/user/cart/presentation/screen/cart_screen.dart';
import 'package:appfoodtour/features/user/home/presentation/screen/home_user_screen.dart';
import 'package:appfoodtour/features/user/order/presentation/screen/order_screen.dart';
import 'package:appfoodtour/features/user/profile/presentation/screen/profile_screen.dart';
import 'package:appfoodtour/features/user/store/presentation/screen/store_list_screen.dart';
import 'package:flutter/material.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({super.key});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeUserScreen(),
    StoreListScreen(),
    OrderScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = [
    'Home',
    'Store',
    'Order',
    'Cart',
    'Profile'
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }
}