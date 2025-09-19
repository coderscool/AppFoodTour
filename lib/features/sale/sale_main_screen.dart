import 'package:appfoodtour/features/sale/profile/presentation/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:appfoodtour/features/sale/home/presentation/screen/home_sale_screen.dart';
import 'package:appfoodtour/features/sale/order/presentation/screen/order_screen.dart';

class SaleMainScreen extends StatefulWidget {
  const SaleMainScreen({super.key});

  @override
  State<SaleMainScreen> createState() => _SaleMainScreenState();
}

class _SaleMainScreenState extends State<SaleMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeSaleScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = [
    'Home',
    'Order',
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
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }
}