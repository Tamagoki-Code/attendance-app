import 'package:attendance_app/sceb_scanner2.dart';
import 'package:attendance_app/sceb_success.dart';
import 'package:attendance_app/sceb_update.dart';
import 'package:flutter/material.dart';

class SCEBEdit extends StatelessWidget {
  const SCEBEdit({super.key});

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

          Positioned(
            top: -98,
            left: 0,
            right: 0,
            child: Transform(
              transform: Matrix4.identity()..scale(1.1, 1.1, 1.0),
              child: Image.asset(
                'assets/purple-top-shape-vector.png',
                height: screenHeight * 0.30,
              ),
            ),
          ),

          Positioned(
            bottom: -70,
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

          // Back Button
          Positioned(
            top: screenHeight * 0.06,
            left: screenWidth * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SCEBSuccess(),
                  ),
                );
              },
              child: Image.asset(
                'assets/ic-back.png',
                height: screenHeight * 0.05,
              ),
            ),
          ),
          //const SizedBox(height: 30),
          // Center Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SMC Logo
                Image.asset(
                  'assets/SMC LOGO CLEARER VERSION.png',
                  height: screenHeight * 0.15,
                ),
                const SizedBox(height: 10),

                // SMCTI Text
                const Text(
                  'SMCTI',
                  style: TextStyle(
                    fontFamily: 'Anton',
                    fontSize: 36,
                    color: Color(0xFF0B1AF2),
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),

                // Edit Event Button
                SizedBox(
                  width: screenWidth * 0.6,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SCEBUpdate(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B1AF2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 65.0, vertical: 23.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: const Text(
                      "Edit Event",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 70),

                // Scanner Button
                SizedBox(
                  width: screenWidth * 0.6,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScebScanner2(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B1AF2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 65.0, vertical: 23.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: const Text(
                      "Scanner",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 350),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
