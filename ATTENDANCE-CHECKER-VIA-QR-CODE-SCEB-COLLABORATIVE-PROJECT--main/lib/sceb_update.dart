import 'package:attendance_app/sceb_edit.dart';
import 'package:attendance_app/sceb_updated_event.dart';
import 'package:flutter/material.dart';

class SCEBUpdate extends StatefulWidget {
  const SCEBUpdate({super.key});

  @override
  State<SCEBUpdate> createState() => _SCEBUpdateState();
}

class _SCEBUpdateState extends State<SCEBUpdate> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
          child: Transform(
            transform: Matrix4.identity()..scale(1.1, 1.1, 1.0),
            child: Image.asset(
              'assets/purple-top-shape-vector.png',
              height: screenHeight * 0.30,
            ),
          ),
        ),

        Positioned(
          bottom: -79,
          left: -1,
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
                  context, MaterialPageRoute(builder: (context) => SCEBEdit()));
            },
            child: Image.asset(
              'assets/ic-back.png',
              height: screenHeight * 0.05,
            ),
          ),
        ),

        // SMC logo
        Positioned(
          top: screenHeight * 0.10,
          left: screenWidth * 0.30,
          child: Image.asset(
            'assets/SMC LOGO CLEARER VERSION.png',
            height: screenHeight * 0.15,
          ),
        ),

        //active events button
        Positioned(
          top: screenHeight * 0.39,
          left: screenWidth * 0.223,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScebUpdatedEvent()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B1AF2),
                padding: const EdgeInsets.symmetric(
                    horizontal: 45.0, vertical: 18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text(
                "Active Events",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        //recent event button
        Positioned(
          top: screenHeight * 0.52,
          left: screenWidth * 0.223,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                // ADD LOGIC HERE FOR THE BUTTON
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B1AF2),
                padding: const EdgeInsets.symmetric(
                    horizontal: 45.0, vertical: 18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text(
                "Recent Events",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        //upcoming event
        Positioned(
          top: screenHeight * 0.65,
          left: screenWidth * 0.223,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                // ADD LOGIC HERE FOR THE BUTTON
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B1AF2),
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text(
                "Upcoming Events",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
