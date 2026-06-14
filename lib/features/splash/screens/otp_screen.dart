import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(6, (_) => FocusNode());

  Timer? timer;
  int seconds = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    seconds = 30;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds == 0) {
          timer.cancel();
        } else {
          setState(() {
            seconds--;
          });
        }
      },
    );
  }

  String get enteredOtp =>
      controllers.map((e) => e.text).join();

  /// Navigate to KYC Screen
  void verifyOtp() {
    if (enteredOtp.length == 6) {
      Navigator.pushReplacementNamed(
        context,
        '/kyc',
      );
    }
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,

        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],

        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE6A100),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE6A100),
              width: 2,
            ),
          ),
        ),

        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            focusNodes[index + 1].requestFocus();
          }

          if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }

          if (enteredOtp.length == 6) {
            verifyOtp();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();

    for (var controller in controllers) {
      controller.dispose();
    }

    for (var focus in focusNodes) {
      focus.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber =
        ModalRoute.of(context)?.settings.arguments
            as String?;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 450,
              ),

              child: Column(
                children: [

                  /// Logo
                  Image.asset(
                    'assets/images/logo2.png',
                    height: 120,
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "OTP Verification",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Enter the OTP sent to +91 ${phoneNumber ?? ''}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                      (index) => otpBox(index),
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: enteredOtp.length == 6
                          ? verifyOtp
                          : null,

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFE6A100),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),

                      child: const Text(
                        "Verify OTP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  seconds == 0
                      ? TextButton(
                          onPressed: () {
                            startTimer();

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "OTP Resent Successfully",
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(
                              color: Color(0xFFE6A100),
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(
                          "Resend OTP in ${seconds}s",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),

                  const SizedBox(height: 40),

                  const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.security,
                            color: Color(0xFFE6A100),
                          ),
                          SizedBox(height: 5),
                          Text("Secure"),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Color(0xFFE6A100),
                          ),
                          SizedBox(height: 5),
                          Text("Trusted"),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.support_agent,
                            color: Color(0xFFE6A100),
                          ),
                          SizedBox(height: 5),
                          Text("24x7 Support"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}