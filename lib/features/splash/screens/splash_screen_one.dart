import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Logo Animation = 4 Seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();

    // Splash Duration = 8 Seconds
    Timer(const Duration(seconds: 8), () {
      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        '/splash2',
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildLogo(double logoSize) {
    return SizedBox(
      width: logoSize,
      height: logoSize,
      child: Image.asset(
        'assets/images/logo2.png',
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    final isDesktop = width > 900;
    final isTablet = width > 600 && width <= 900;

    final logoSize = isDesktop
        ? 500.0
        : isTablet
            ? 380.0
            : width * 0.75;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// Top Left Glow
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: width * 0.45,
              height: width * 0.45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD8ECFF)
                    .withOpacity(0.65),
              ),
            ),
          ),

          /// Top Right Glow
          Positioned(
            top: 50,
            right: -80,
            child: Container(
              width: width * 0.28,
              height: width * 0.28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEAF5FF)
                    .withOpacity(0.65),
              ),
            ),
          ),

          /// Bottom Waves
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: height * 0.28,
              width: double.infinity,
              child: CustomPaint(
                painter: WavePainter(),
              ),
            ),
          ),

          /// Main Content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildLogo(logoSize),

                    SizedBox(
                      height: isDesktop
                          ? 25
                          : isTablet
                              ? 20
                              : 15,
                    ),

                    Text(
                      "Trusted Payments. Limitless Growth.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF243B6B),
                        fontSize: isDesktop
                            ? 24
                            : isTablet
                                ? 20
                                : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: 120,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37),
                        borderRadius:
                            BorderRadius.circular(50),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD4AF37),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFFEAF2FF);

    final paint2 = Paint()
      ..color = const Color(0xFFF6FAFF);

    final paint3 = Paint()
      ..color = const Color(0xFFDDEEFF);

    Path path1 = Path()
      ..moveTo(0, 80)
      ..quadraticBezierTo(
        size.width * .25,
        20,
        size.width * .5,
        80,
      )
      ..quadraticBezierTo(
        size.width * .75,
        150,
        size.width,
        70,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    Path path2 = Path()
      ..moveTo(0, 140)
      ..quadraticBezierTo(
        size.width * .25,
        70,
        size.width * .5,
        140,
      )
      ..quadraticBezierTo(
        size.width * .75,
        220,
        size.width,
        120,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    Path path3 = Path()
      ..moveTo(0, 190)
      ..quadraticBezierTo(
        size.width * .25,
        120,
        size.width * .5,
        190,
      )
      ..quadraticBezierTo(
        size.width * .75,
        260,
        size.width,
        170,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path3, paint3);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}