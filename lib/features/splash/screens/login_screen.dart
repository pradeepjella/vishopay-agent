import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController =
      TextEditingController();

  bool get isValidPhone =>
      RegExp(r'^[6-9]\d{9}$')
          .hasMatch(_phoneController.text);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isDesktop = size.width > 900;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop
                    ? 500
                    : isTablet
                        ? 450
                        : double.infinity,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [

                  /// LOGO
                  Image.asset(
                    'assets/images/logo2.png',
                    height: 120,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Login to your VishoPay Agent account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// MOBILE FIELD
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.05),
                          blurRadius: 15,
                        ),
                      ],
                    ),

                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType:
                          TextInputType.phone,

                      maxLength: 10,

                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly,
                        LengthLimitingTextInputFormatter(
                          10,
                        ),
                      ],

                      onChanged: (_) {
                        setState(() {});
                      },

                      decoration: InputDecoration(
                        counterText: "",

                        border: InputBorder.none,

                        contentPadding:
                            const EdgeInsets.symmetric(
                          vertical: 20,
                        ),

                        prefixIcon: Container(
                          width: 90,
                          alignment: Alignment.center,
                          child: const Text(
                            "+91",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        hintText:
                            "Enter Mobile Number",
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: const [
                      Icon(
                        Icons.security,
                        color: Color(0xFFE6A100),
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "We will send an OTP to verify your number",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  /// SEND OTP BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 58,

                    child: ElevatedButton(
                      onPressed: isValidPhone
                          ? () {
                              Navigator.pushNamed(
                                context,
                                '/otp',
                                arguments:
                                    _phoneController
                                        .text,
                              );
                            }
                          : null,

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                          0xFFE6A100,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),
                      ),

                      child: const Text(
                        "Send OTP",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.verified_user,
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