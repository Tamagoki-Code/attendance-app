import 'package:attendance_app/sceb_edit.dart';
import 'package:flutter/material.dart';

class SCEBSuccess extends StatelessWidget {
  const SCEBSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQueary.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),

          Positioned(
            top: -100,
            left: 0,
            right: 0,
            child: Transform.scale(
              scale: 1.1,
              child: Image.asset(
                'assets/purple-top-shape-vector.png',
                height: screenHeight * 0.30,
              ),
            ),
          ),

          Positioned(
            bottom: -80,
            left: -5,
            right: 0,
            child: Transform(
              transform: Matrix4.identity()..scale(1.1, 1.1, 1.0),
              child: Image.asset(
                'assets/purple-bottom-shape-vector.png',
                height: screenHeight * 0.30,
              ),
            ),
          ),

          // SMC logo at the top
          Positioned(
            top: screenHeight * 0.09,
            left: screenWidth * 0.40,
            child: Image.asset(
              'assets/SMC LOGO CLEARER VERSION.png',
              height: screenHeight * 0.12,
            ),
          ),

          // Centering content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/account-created-status-2.png',
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 20,
                  width: 150,
                ),
                const Text(
                  'Account Created!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF0B1AF2),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 150,
                  child: Text(
                    'Your account has been created',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFF000000),
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B1AF2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w200,
                      fontSize: 14,
                      color: Color(0xFF000000),
                      letterSpacing: -0.12,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SCEBEdit(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B1AF2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 65.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MediaQueary {
  static of(BuildContext context) {}
}
