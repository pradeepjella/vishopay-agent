import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({super.key});

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        '/login',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,

        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,

          child: SizedBox(
            width: 1365,
            height: 1024,

            child: Image.asset(
              'assets/images/agent3.png',
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ),
    );
  }
}