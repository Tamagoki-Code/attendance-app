import 'package:flutter/material.dart';

class ScebScanner2 extends StatefulWidget {
  const ScebScanner2({super.key});

  @override
  State<ScebScanner2> createState() => _ScebScanner2State();
}

class _ScebScanner2State extends State<ScebScanner2> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          //BACKGROUND COLOR
          Positioned.fill(
            child: Container(
              color: const Color(0xFF10166F),
            ),
          ),

          //ELLIPSE SHAPE ON TOP
          Positioned(
            top: -85,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/sceb-scanner-ellipse-2.png',
              height: screenHeight * 0.50,
            ),
          ),

          // SMC logo
          Positioned(
            top: screenHeight * 0.05, // 5% from the top
            left: screenWidth *
                0.35, // Centered horizontally with 35% padding from the left
            child: Image.asset(
              'assets/SMC LOGO CLEARER VERSION.png',
              height: screenHeight * 0.18, // 15% of the screen height
            ),
          ),

          Positioned(
            top: screenHeight * 0.27,
            left: screenWidth * 0.06,
            child: Container(
              height: 124.0,
              width: 367.0,
              decoration: BoxDecoration(
                color: const Color(0xFF585FB9),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.45),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(3, 6),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: screenHeight * 0.009,
                    left: screenWidth * 0.012,
                    child: Container(
                        height: 112.0,
                        width: 356.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(9.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25.0,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: "NAME:",
                                        labelStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 2.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  SizedBox(
                                    height: 25.0,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: "PROGRAM:",
                                        labelStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 2.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  SizedBox(
                                    height: 25.0,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: "YEAR:",
                                        labelStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 2.0),
                                      ),
                                    ),
                                  ),
                                ]))),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.55,
            left: screenWidth * 0.08,
            child: Container(
              height: 370.0,
              width: 362.0,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/sample-qr.png',
                    height: screenHeight * 0.27,
                    width: screenWidth * 0.5,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
