import 'package:attendance_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/notification-drawer.dart';

class Account extends StatefulWidget {
  final VoidCallback onNotificationTap;
  const Account({super.key, required this.onNotificationTap});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool _isNotifSidebarOpen = false;

  void _toggleNotifSidebar() {
    setState(() {
      _isNotifSidebarOpen = !_isNotifSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Transform.translate(
          offset: Offset.zero,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(2, 0),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Profile Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeContent()));
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage("assets/SMC LOGO CLEARER VERSION.png"),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "John Smith",
                        style: TextStyle(
                          color: Color(0xFF0B1AF2),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "ID NUMBER: C204599",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white54),
                _buildDrawerItem(Icons.dashboard, "Dashboard", context),
                _buildDrawerItem(Icons.event, "Events Board", context),
                _buildDrawerItem(Icons.notifications, "Notification", context),
                _buildDrawerItem(Icons.lock, "Privacy", context),
                _buildDrawerItem(Icons.logout, "Log out", context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {
        if (title == "Notification") {
          // Open the NotificationDrawer
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  NotificationDrawer(
                onClose: _toggleNotifSidebar,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        } else {
          // Handle other items (e.g., close the sidebar)
          Navigator.pop(context);
        }
      },
    );
  }
}
