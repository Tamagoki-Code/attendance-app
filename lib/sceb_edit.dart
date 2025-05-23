import 'package:attendance_app/sceb_scanner2.dart';
import 'package:attendance_app/sceb_success.dart';
import 'package:attendance_app/sceb_update.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/sceb_office.dart';

class SCEBEdit extends StatelessWidget {
  const SCEBEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    const double baseScreenWidth = 375.0;
    const double baseScreenHeight = 812.0;

    double getResponsiveHeight(double value) {
      return (value / baseScreenHeight) * screenHeight;
    }

    double getResponsiveWidth(double value) {
      return (value / baseScreenWidth) * screenWidth;
    }

    double getResponsiveFontSize(double value) {
      return (value / baseScreenWidth) * screenWidth;
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/QR-CODE-BG.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: getResponsiveHeight(-98.0),
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
            bottom: getResponsiveHeight(-70.0),
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
          Positioned(
            top: screenHeight * 0.20,
            bottom: screenHeight * 0.20,
            left: 0,
            right: 0,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: getResponsiveWidth(30.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/SMC LOGO CLEARER VERSION.png',
                    height: screenHeight * 0.15,
                  ),
                  Text(
                    'SMCTI',
                    style: TextStyle(
                      fontFamily: 'Anton',
                      fontSize: getResponsiveFontSize(36.0),
                      color: const Color(0xFF0B1AF2),
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: getResponsiveWidth(250.0),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: getResponsiveWidth(65.0),
                            vertical: getResponsiveHeight(23.0)),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(getResponsiveWidth(15.0)),
                        ),
                      ),
                      child: Text(
                        "Edit Event",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: getResponsiveFontSize(20.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getResponsiveWidth(250.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SCEBOffice(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B1AF2),
                        padding: EdgeInsets.symmetric(
                            horizontal: getResponsiveWidth(65.0),
                            vertical: getResponsiveHeight(23.0)),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(getResponsiveWidth(15.0)),
                        ),
                      ),
                      child: Text(
                        "SCEB Office",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: getResponsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getResponsiveWidth(250.0),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: getResponsiveWidth(65.0),
                            vertical: getResponsiveHeight(23.0)),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(getResponsiveWidth(15.0)),
                        ),
                      ),
                      child: Text(
                        "Scanner",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: getResponsiveFontSize(20.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
