import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() =>
      _WaitingScreenState();
}

class _WaitingScreenState
    extends State<WaitingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget statusItem(
    IconData icon,
    String title,
    String status,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor:
                color.withOpacity(0.1),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),

          Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFFDFDFD),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.all(20),

            child: Column(
              children: [
                const SizedBox(height: 20),

                /// LOGO
                Image.asset(
                  "assets/images/logo2.png",
                  height: 120,
                ),

                const SizedBox(height: 20),

                /// STATUS TRACKER
                Container(
                  padding:
                      const EdgeInsets.all(
                    16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(
                          0.05,
                        ),
                        blurRadius: 12,
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      statusItem(
                        Icons.description,
                        "Submitted",
                        "Completed",
                        Colors.green,
                      ),

                      statusItem(
                        Icons.settings,
                        "Review",
                        "In Progress",
                        const Color(
                          0xFFE6A100,
                        ),
                      ),

                      statusItem(
                        Icons.verified_user,
                        "Verify",
                        "Pending",
                        Colors.grey,
                      ),

                      statusItem(
                        Icons.person,
                        "Active",
                        "Pending",
                        Colors.grey,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                /// ROTATING GEAR
                SizedBox(
                  height: 260,
                  width: 260,

                  child: Stack(
                    alignment:
                        Alignment.center,

                    children: [
                      Container(
                        height: 260,
                        width: 260,

                        decoration:
                            BoxDecoration(
                          shape:
                              BoxShape.circle,
                          color:
                              const Color(
                            0xFFFFF8E8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors
                                  .orange
                                  .withOpacity(
                                0.15,
                              ),
                              blurRadius:
                                  25,
                            ),
                          ],
                        ),
                      ),

                      RotationTransition(
                        turns:
                            _controller,

                        child: const Icon(
                          Icons.settings,
                          size: 140,
                          color:
                              Color(
                            0xFFE6A100,
                          ),
                        ),
                      ),

                      Container(
                        height: 60,
                        width: 60,

                        decoration:
                            const BoxDecoration(
                          color:
                              Colors.white,
                          shape:
                              BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Your Application is",
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const Text(
                  "Under Review",
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFFE6A100),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Our verification team is reviewing your details and documents.",
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Verification may take up to 24 Hours",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.w700,
                    color:
                        Color(0xFFE6A100),
                  ),
                ),

                const SizedBox(height: 30),

                /// NOTIFICATION CARD
                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        const Color(
                      0xFFFFFBF3,
                    ),

                    borderRadius:
                        BorderRadius
                            .circular(
                      20,
                    ),

                    border: Border.all(
                      color:
                          const Color(
                        0xFFFFD98B,
                      ),
                    ),
                  ),

                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor:
                            Color(
                          0xFFFFE9BF,
                        ),

                        child: Icon(
                          Icons
                              .notifications_active,
                          size: 35,
                          color:
                              Color(
                            0xFFE6A100,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 15,
                      ),

                      const Expanded(
                        child: Text(
                          "You will receive SMS and WhatsApp notifications once your KYC is approved.",
                          style:
                              TextStyle(
                            fontSize:
                                15,
                            height:
                                1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                /// SECURITY CARD
                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

                  decoration:
                      BoxDecoration(
                    gradient:
                        const LinearGradient(
                      colors: [
                        Color(
                          0xFFE9FFF1,
                        ),
                        Color(
                          0xFFF7FFF9,
                        ),
                      ],
                    ),

                    borderRadius:
                        BorderRadius
                            .circular(
                      20,
                    ),
                  ),

                  child: const Row(
                    children: [
                      Icon(
                        Icons.shield,
                        size: 60,
                        color:
                            Colors.green,
                      ),

                      SizedBox(
                        width: 20,
                      ),

                      Expanded(
                        child: Text(
                          "Your Data Is Safe With Us\n\n100% Secure & Encrypted",
                          style:
                              TextStyle(
                            fontWeight:
                                FontWeight
                                    .w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  "Thank You For Choosing",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "VishoPay",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFFE6A100),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}