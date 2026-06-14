import 'package:flutter/material.dart';

import 'features/splash/screens/splash_screen_one.dart';
import 'features/splash/screens/splash_screen_two.dart';
import 'features/splash/screens/login_screen.dart';
import 'features/splash/screens/otp_screen.dart';
import 'features/kyc/screens/kyc_form.dart';
import 'features/kyc/screens/waiting_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const VishoPayApp());
}

class VishoPayApp extends StatelessWidget {
  const VishoPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VishoPay',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFFE6A100),
        scaffoldBackgroundColor: Colors.white,
      ),

      initialRoute: '/',

      routes: {
        /// Splash Screen 1
        '/': (context) => const SplashScreen1(),

        /// Splash Screen 2
        '/splash2': (context) => const SplashScreenTwo(),

        /// Login Screen
        '/login': (context) => const LoginScreen(),

        /// OTP Screen
        '/otp': (context) => const OtpScreen(),

        /// KYC Form Screen
        '/kyc': (context) => const KycForm(),

        '/waiting': (context) =>
    const WaitingScreen(),
      },
    );
  }
}