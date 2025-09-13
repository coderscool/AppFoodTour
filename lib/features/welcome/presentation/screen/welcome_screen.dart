import 'package:appfoodtour/features/delivery/home/presentation/screen/home_delivery_screen.dart';
import 'package:appfoodtour/features/sale/home/presentation/screen/home_sale_screen.dart';
import 'package:appfoodtour/features/services/local_storage_service.dart';
import 'package:appfoodtour/features/services/location_service.dart';
import 'package:appfoodtour/features/user/footer/presentation/screen/user_main_screen.dart';
//import 'package:appfoodtour/features/user/home/presentation/screen/home_user_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), _handleNavigation);
  }

  Future<void> _handleNavigation() async {
    bool isLoggedIn = await LocalStorageService.isLoggedIn();
    String role = await LocalStorageService.getUserRole();

    // Điều kiện để lấy vị trí
    if (!isLoggedIn || role == 'user' || role == 'shipper') {
      final position = await LocationService.getCurrentPosition();

      if (position != null) {
        debugPrint('🌍 Vị trí người dùng: ${position.latitude}, ${position.longitude}');
        // Có thể lưu vào biến toàn cục, service hoặc SharedPreferences nếu cần
      } else {
        debugPrint('⚠️ Không thể lấy vị trí người dùng');
      }
    }

    // Điều hướng
    Widget nextScreen;
    if (!isLoggedIn || role == 'user') {
      nextScreen = const UserMainScreen();
    } else if (role == 'sale') {
      nextScreen = const HomeSaleScreen();
    } else if (role == 'shipper') {
      nextScreen = const HomeDeliveryScreen();
    } else {
      nextScreen = const UserMainScreen();
    }

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Chào mừng bạn đến Food Tour',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
