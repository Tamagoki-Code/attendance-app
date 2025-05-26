import 'dart:ui';

import 'package:attendance_app/account.dart';
import 'package:attendance_app/attendance.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/notification-drawer.dart';
import 'event_cards_list.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _selectedIndex = 0;
  bool _isAccountSidebarOpen = false;
  bool _isNotifSidebarOpen = false;

  // Responsive utility functions
  static const double baseScreenWidth = 375.0;
  static const double baseScreenHeight = 812.0;

  double getResponsiveHeight(double value) {
    return (value / baseScreenHeight) * MediaQuery.of(context).size.height;
  }

  double getResponsiveWidth(double value) {
    return (value / baseScreenWidth) * MediaQuery.of(context).size.width;
  }

  double getResponsiveFontSize(double value) {
    return (value / baseScreenWidth) * MediaQuery.of(context).size.width;
  }

  void _toggleAccountSidebar() {
    setState(() {
      _isAccountSidebarOpen = !_isAccountSidebarOpen;
    });
  }

  void _toggleNotifSidebar() {
    setState(() {
      _isNotifSidebarOpen = !_isNotifSidebarOpen;
    });
  }

  Widget navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF0B1AF2) : Colors.black54,
          size: getResponsiveWidth(26),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: getResponsiveFontSize(12),
            fontWeight: FontWeight.bold,
            color: isActive ? const Color(0xFF0B1AF2) : Colors.black54,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavBarHeight = getResponsiveHeight(56.0);
    final topBarOffset = getResponsiveHeight(40.0);

    // --- REFINED CARD HEIGHTS from event_cards_list.dart ---
    final double happeningNowCardHeight = getResponsiveHeight(
        145); // Height for 'Happening Now' with Attend button
    final double otherCardsHeight = getResponsiveHeight(
        130); // Shorter height for Recent/Upcoming with warning strip

    return Scaffold(
      body: Stack(
        children: [
          // Background Image (Cubes.png)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/Cubes.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blue diagonal shape - Adjusted height to be higher
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: getResponsiveHeight(
                  350), // Decreased from 500 to 350 to make blue background higher
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/diagonal_background.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),

          // Top Section: Menu Icon and Logo
          Positioned(
            top: topBarOffset,
            left: getResponsiveWidth(16),
            right: getResponsiveWidth(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                Container(
                  width: getResponsiveWidth(60),
                  height: getResponsiveHeight(60),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/SMC LOGO CLEARER VERSION.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Welcome Text Section - Now positioned independently
          Positioned(
            top: topBarOffset +
                getResponsiveHeight(70), // Adjusted top for Welcome text
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "WELCOME",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getResponsiveFontSize(22),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "MARIANISTA",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getResponsiveFontSize(22),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      height: getResponsiveHeight(5)), // Consistent spacing
                  Text(
                    "Check your attendance virtually!",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: getResponsiveFontSize(11),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content Area (Cards) - Adjusted top position to be lower and prevent overflow
          Positioned(
            top: topBarOffset +
                getResponsiveHeight(
                    200.0), // Adjusted from 230 to 200 to lift cards slightly while maintaining spacing
            bottom:
                bottomNavBarHeight, // No additional padding to ensure fit and avoid overflow
            left: 0,
            right: 0,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: getResponsiveWidth(16.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Distributes space evenly
                children: [
                  // Happening Now Event Card (the label is now inside EventCardsList)
                  SizedBox(
                    height: happeningNowCardHeight,
                    child: const EventCardsList(
                      collectionName: 'events',
                      showAttendButton: true,
                    ),
                  ),
                  SizedBox(
                      height: getResponsiveHeight(10)), // Spacing between cards

                  // Recent Activities Section Header
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "RECENT ACTIVITIES",
                      style: TextStyle(
                        color: const Color(0xFF0B1AF2),
                        fontSize: getResponsiveFontSize(14),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Recent Activities Event Card
                  SizedBox(
                    height: otherCardsHeight,
                    child: const EventCardsList(
                      collectionName: 'recent_events',
                      showAttendButton: false,
                    ),
                  ),
                  SizedBox(
                      height: getResponsiveHeight(10)), // Spacing between cards

                  // Upcoming Activities Section Header
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "UPCOMING ACTIVITIES",
                      style: TextStyle(
                        color: const Color(0xFF0B1AF2),
                        fontSize: getResponsiveFontSize(14),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Upcoming Activities Event Card
                  SizedBox(
                    height: otherCardsHeight,
                    child: const EventCardsList(
                      collectionName: 'upcoming_events',
                      showAttendButton: false,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Account Sidebar (overlay)
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

          // Notification Sidebar (overlay)
          if (_isNotifSidebarOpen)
            GestureDetector(
              onTap: _toggleNotifSidebar,
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
            _selectedIndex = index;
          });

          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Attendance()),
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
