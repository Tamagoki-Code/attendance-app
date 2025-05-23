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
    const horizontalPadding = 20.0;
    final contentWidth = screenWidth - 2 * horizontalPadding;
    const inputFieldsHeight = 124.0;
    const logoHeightFactor = 0.40;
    final logoHeight = screenHeight * logoHeightFactor;
    final logoWidth = logoHeight * (contentWidth / screenHeight);
    final logoTop = screenHeight * -0.05; // Moved logo down a bit
    final logoLeft = horizontalPadding + (contentWidth - logoWidth) / 2;

    const qrCodeContainerHeightFactor = 0.35;
    final qrCodeContainerHeight = screenHeight * qrCodeContainerHeightFactor;
    final targetQrCodeContainerWidth = qrCodeContainerHeight * 0.9;
    final adjustedQrCodeContainerWidth =
        targetQrCodeContainerWidth > contentWidth
            ? contentWidth
            : targetQrCodeContainerWidth;
    final qrCodeContainerLeft =
        horizontalPadding + (contentWidth - adjustedQrCodeContainerWidth) / 2;
    final qrCodeContainerTop =
        screenHeight * 0.50; // Moved QR code container down a bit

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color(0xFF10166F),
            ),
          ),
          Positioned(
            top: -screenHeight * 0.085,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/sceb-scanner-ellipse-2.png',
              height: screenHeight * 0.50,
              width: screenWidth,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: logoTop,
            left: logoLeft,
            child: Image.asset(
              'assets/SMC LOGO CLEARER VERSION.png',
              height: logoHeight,
              width: logoWidth,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: screenHeight * 0.27,
            left: horizontalPadding,
            child: SizedBox(
              width: contentWidth,
              child: Container(
                height: inputFieldsHeight,
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
                      top: 6.0,
                      left: 5.5,
                      child: Container(
                        height: inputFieldsHeight - 12.0,
                        width: contentWidth - 11.0,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: qrCodeContainerTop,
            left: qrCodeContainerLeft,
            child: Container(
              height: qrCodeContainerHeight,
              width: adjustedQrCodeContainerWidth,
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
                    height: adjustedQrCodeContainerWidth * 0.7,
                    width: adjustedQrCodeContainerWidth * 0.7,
                    fit: BoxFit.contain,
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
