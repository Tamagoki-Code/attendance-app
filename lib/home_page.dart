import 'dart:ui';

import 'package:attendance_app/account.dart';
import 'package:attendance_app/attendance.dart';
import 'package:attendance_app/qr_success.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:attendance_app/notification-drawer.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _selectedIndex = 0;
  bool _isAccountSidebarOpen = false;
  bool _isNotifSidebarOpen = false;

  void _toggleAccountSidebar() {
    setState(() {
      _isAccountSidebarOpen = !_isAccountSidebarOpen;
    });
  }

  void _toggleNotifSidebar() {
    setState(() {
      _isNotifSidebarOpen = !_isAccountSidebarOpen;
    });
  }

  final PageController _pageController = PageController(viewportFraction: 0.9);

  Widget eventCard(String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget upcomingEventCard(String title, String date) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 120,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFF0B1AF2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Colors.blueAccent, width: 1.5), // Highlighted border
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const SizedBox(width: 4),
                Text(
                  date,
                  style: const TextStyle(fontSize: 10, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF0B1AF2) : Colors.black54,
          size: 26,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isActive ? const Color(0xFF0B1AF2) : Colors.black54,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/Cubes.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blue diagonal shape

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/diagonal_background.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Row(
                            children: [
                              Icon(Icons.search, color: Colors.white),
                              SizedBox(width: 5),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search...",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                  ),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/SMC LOGO CLEARER VERSION.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Welcome Text
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "WELCOME",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "MARIANISTA",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Check your attendance virtually!",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 70),

                  // "HAPPENING NOW" text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B1AF2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "HAPPENING NOW..",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Event Card and Image
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Blue card
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Container(
                          width: 150,
                          height: 160,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0B1AF2),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          color: Colors.white, size: 16),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          "August 02, 2024",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "School Gym",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.access_time,
                                          color: Colors.white, size: 16),
                                      SizedBox(width: 5),
                                      Text(
                                        "8:00 AM",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Success(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0XFF0B1AF2),
                                    minimumSize: const Size(100, 30),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    "ATTEND",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Event Image
                      Positioned(
                        left: 150,
                        top: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/sample-pic.png",
                            width: 260,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Event Text
                      Positioned(
                        bottom: 15,
                        left: 180,
                        child: Text(
                          "FIRST FRIDAY MASS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Recent Activities
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "RECENT ACTIVITIES",
                      style: TextStyle(
                        color: Color(0xFF0B1AF2),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // PageView Slider
                  SizedBox(
                    height: 180,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        eventCard(
                            "assets/sample-pic.png", "ACQUAINTANCE PARTY"),
                        eventCard("assets/sample-pic.png", "SPORTS FESTIVAL"),
                        eventCard("assets/sample-pic.png", "OUTREACH PROGRAM"),
                      ],
                    ),
                  ),

                  // SmoothPageIndicator
                  Transform.translate(
                    offset: const Offset(0, -10),
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.blueAccent,
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Coming Up
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "COMING UP",
                      style: TextStyle(
                        color: Color(0xFF0B1AF2),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Upcoming Events List
                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        upcomingEventCard("BUWAN NG WIKA", "Aug 15, 2024"),
                        upcomingEventCard("TEACHER'S DAY", "Oct 5, 2024"),
                        upcomingEventCard("FOUNDATION DAY", "Dec 12, 2024"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Account Sidebar
          if (_isAccountSidebarOpen)
            GestureDetector(
              onTap: _toggleAccountSidebar,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          if (_isAccountSidebarOpen)
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.75,
                child: Account(
                  onNotificationTap: _toggleNotifSidebar,
                ),
              ),
            ),

          // Notification Sidebar
          if (_isNotifSidebarOpen)
            GestureDetector(
              onTap: _toggleAccountSidebar,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          if (_isNotifSidebarOpen)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: FractionallySizedBox(
                widthFactor: 0.75,
                child: NotificationDrawer(
                  onClose: _toggleNotifSidebar,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });

          // Navigate to the corresponding screen
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeContent()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Attendance()),
              );
              break;
            case 2:
              _toggleAccountSidebar();
              break;
          }
        },
        selectedItemColor: const Color(0xFF0B1AF2),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
