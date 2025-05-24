import 'dart:ui';

import 'package:attendance_app/account.dart';
import 'package:attendance_app/attendance.dart';
import 'package:attendance_app/qr_success.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:attendance_app/notification-drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'event_cards_list.dart';
import 'package:intl/intl.dart'; // For date parsing and formatting

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
          // Search Bar Row — Fixed Position
Positioned(
  top: 40, // Adjust this value if needed to avoid overlap
  left: 16,
  right: 16,
  child: Row(
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
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: 60,
        height: 60,
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

// Main Content
SafeArea(
  child: Padding(
    padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                const SizedBox(height: 90),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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

          
          const SizedBox(height: 20),

          // Happening Now Section
          EventCardsList(
            collectionName: 'events',
            showAttendButton: true,
          ),

          const SizedBox(height: 40),

          // Recent Activities Section Header
          Align(
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

          const SizedBox(height: 30),

          EventCardsList(
            collectionName: 'recent_events',
            showAttendButton: false,
          ),

          const SizedBox(height: 40),

          // Upcoming Activities Section Header
          Align(
            alignment: Alignment.center,
            child: Text(
              "UPCOMING ACTIVITIES",
              style: TextStyle(
                color: Color(0xFF0B1AF2),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          EventCardsList(
            collectionName: 'upcoming_events',
            showAttendButton: false,
          ),
        ],
      ),
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