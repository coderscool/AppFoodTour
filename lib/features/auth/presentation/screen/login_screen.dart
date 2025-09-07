import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_buttons.dart';
import '../widgets/signup_footer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header với ảnh + logo app
              SizedBox(
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      "assets/images/header_bg.jpg", // ảnh nền
                      fit: BoxFit.cover,
                    ),
                    Container(color: Colors.black.withOpacity(0.3)),
                    const Center(
                      child: Text(
                        "Nesz",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Let's Connect With Us!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: LoginForm(),
              ),

              const SizedBox(height: 20),

              const SocialLoginButtons(),

              const SizedBox(height: 20),

              const SignupFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
