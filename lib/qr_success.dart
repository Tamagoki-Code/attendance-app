import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/QR-CODE-BG.png',
              fit: BoxFit.cover,
            ),
          ),

          // SMC logo
          Positioned(
            top: screenHeight * 0.05, // 5% from the top
            left: screenWidth * 0.38, // Centered horizontally with 35% padding from the left
            child: Image.asset(
              'assets/SMC LOGO CLEARER VERSION.png',
              height: screenHeight * 0.15, // 15% of the screen height
            ),
          ),

          // SMCTI text
          Positioned(
            top: screenHeight * 0.20, // Adjust this value for spacing below the logo
            left: screenWidth * 0.35, // Center text horizontally
            child: const Text(
              'SMCTI',
              style: TextStyle(
                fontFamily: 'Anton', // Custom font name
                fontSize: 36,        // Adjust size
                color: Color(0xFF0B1AF2),
                letterSpacing: 0.5,  
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.31,
            left: screenWidth * 0.28, 
            child: const Text(
              'SCAN QR FOR ATTENDANCE',
              style: TextStyle(
                fontFamily: 'Arimo-Regular',
                fontSize: 10,
                color: Color(0xFF13548A),
                letterSpacing: -0.2,
              ),
            ),  
          ),

          Positioned(
            top: screenHeight * 0.38,
            left: screenWidth * 0.21, 
            child: Container(
              height: 160.0,
              width: 160.0,
              color: const Color(0xFF1F139A),
            ),
          ),

          // Overlay with #1F1F39 and 60% opacity
          Positioned.fill(
            child: Container(
              color: const Color(0x991F1F39), // Semi-transparent dark blue
            ),
          ),

          Positioned(
            top: screenHeight * 0.40,
            left: screenWidth * 0.17, 
            child: Container(
              height: 175.0,
              width: 180.0,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: screenHeight * 0.02,
                    left: screenWidth * 0.22,
                    child: Image.asset(
                      'assets/ic-done-status.png',
                      height: 60.0,
                      width: 60.0,
                    ),
                  ),

                  Positioned(
                    top: screenHeight * 0.15,
                    left: screenWidth * 0.23,
                    child: const Text(
                      'Success',
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w500,  // Correct way to specify font weight
                      ),
                    ),
                  ),

                  Positioned(
                    top: screenHeight * 0.20,
                    left: screenWidth * 0.05, 
                    child: Container(
                      width: 150.0,
                      child: const Text(
                        'Attendance Confirmed. Thank you for your participation.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.2,
                          color: const Color(0xFF858597),
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),

                  Positioned(
                    top: screenHeight * 0.28,
                    left: screenWidth * 0.14, 
                    child: Container(
                      height: 30.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B1AF2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: screenHeight * 0.012, 
                            left: screenWidth * 0.135, 
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                                color: Colors.white, 
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
