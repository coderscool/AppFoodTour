import 'package:appfoodtour/features/welcome/presentation/screen/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Tour App',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(), // Luôn hiển thị màn hình Welcome khi mở app
    );
  }
}
