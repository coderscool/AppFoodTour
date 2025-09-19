import 'package:appfoodtour/features/delivery/home/presentation/screen/home_delivery_screen.dart';
import 'package:appfoodtour/features/sale/sale_main_screen.dart';
import 'package:appfoodtour/features/user/home/presentation/screen/home_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_buttons.dart';
import '../widgets/signup_footer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          if (state.user.role == "seller") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const SaleMainScreen()
              ),
                  (Route<dynamic> route) => false,
            );
          } else if (state.user.role == "user") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeUserScreen(),
              ),
            );
          } else if (state.user.role == "shipper") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeDeliveryScreen(),
              ),
            );
          }
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header với ảnh + logo app
                      SizedBox(
                        height: 300,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              "assets/logo.jpg",
                              fit: BoxFit.cover,
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

                // Loading overlay khi state = AuthLoading
                if (state is AuthLoading)
                  Container(
                    color: Colors.black45,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
