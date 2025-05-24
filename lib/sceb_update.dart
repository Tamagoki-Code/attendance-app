import 'package:attendance_app/sceb_edit.dart';

// Aliased imports to avoid conflict
import 'package:attendance_app/sceb_updated_event.dart' as updatedEvent;
import 'package:attendance_app/sceb_updated_upcoming_event.dart' as updatedUpcoming;
import 'package:attendance_app/sceb_updated_recent_event.dart' as updatedRecent;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class SCEBUpdate extends StatefulWidget {
  const SCEBUpdate({super.key});

  @override
  State<SCEBUpdate> createState() => _SCEBUpdateState();
}

class _SCEBUpdateState extends State<SCEBUpdate> {
  bool _isSyncing = false;

  // Initialize timezone data once
  @override
  void initState() {
    super.initState();
    tzdata.initializeTimeZones();
  }

  // Parse date string assuming format "yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd"
  DateTime? _parseDateString(String? dateStr) {
    if (dateStr == null) return null;

    try {
      // Try parsing full datetime first
      return DateTime.parse(dateStr);
    } catch (_) {
      try {
        // Try parsing date only
        return DateTime.parse(dateStr + ' 00:00:00');
      } catch (_) {
        return null;
      }
    }
  }

  // Get today's date in Philippines timezone, with zeroed time
  DateTime _todayPhilippines() {
    final phTz = tz.getLocation('Asia/Manila');
    final now = tz.TZDateTime.now(phTz);
    return DateTime(now.year, now.month, now.day);
  }

  Future<void> _syncEvents() async {
    setState(() {
      _isSyncing = true;
    });

    final firestore = FirebaseFirestore.instance;
    final phTz = tz.getLocation('Asia/Manila');
    final today = _todayPhilippines();
    final now = tz.TZDateTime.now(phTz);

    try {
      // 1) Move upcoming_events -> events if event date == today
      final upcomingSnapshot = await firestore.collection('upcoming_events').get();
      for (var doc in upcomingSnapshot.docs) {
        final data = doc.data();
        final dateStr = data['date'] as String?;
        final eventDate = _parseDateString(dateStr);

        if (eventDate != null) {
          final eventDateInPH = tz.TZDateTime.from(eventDate, phTz);
          final eventDateOnly = DateTime(eventDateInPH.year, eventDateInPH.month, eventDateInPH.day);

          if (eventDateOnly == today) {
            // Copy to events
            await firestore.collection('events').doc(doc.id).set(data);
            // Delete from upcoming_events
            await firestore.collection('upcoming_events').doc(doc.id).delete();
          }
        }
      }

      // 2) Move events -> recent_events if event date + 5 hours < now
      final eventsSnapshot = await firestore.collection('events').get();
      for (var doc in eventsSnapshot.docs) {
        final data = doc.data();
        final dateStr = data['date'] as String?;
        final eventDate = _parseDateString(dateStr);

        if (eventDate != null) {
          final eventDateInPH = tz.TZDateTime.from(eventDate, phTz);
          final eventPlus5Hours = eventDateInPH.add(const Duration(hours: 5));

          if (eventPlus5Hours.isBefore(now)) {
            // Copy to recent_events
            await firestore.collection('recent_events').doc(doc.id).set(data);
            // Delete from events
            await firestore.collection('events').doc(doc.id).delete();
          }
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Events synchronized successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sync failed: $e')),
      );
    }

    setState(() {
      _isSyncing = false;
    });
  }

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

        // Back button top-left
        Positioned(
          top: screenHeight * 0.06,
          left: screenWidth * 0.05,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SCEBEdit()));
            },
            child: Image.asset(
              'assets/ic-back.png',
              height: screenHeight * 0.05,
            ),
          ),
        ),

        // Sync Events button top-right
        Positioned(
          top: screenHeight * 0.06,
          right: screenWidth * 0.05,
          child: ElevatedButton(
            onPressed: _isSyncing ? null : _syncEvents,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B1AF2),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: _isSyncing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    "Sync Events",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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

        // Active Events Button
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
                        builder: (context) =>
                            const updatedEvent.ScebUpdatedEvent()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B1AF2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 45.0, vertical: 18.0),
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

        // Recent Events Button
        Positioned(
          top: screenHeight * 0.52,
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
                      builder: (context) =>
                          const updatedRecent.ScebUpdatedRecentEvent()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B1AF2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 45.0, vertical: 18.0),
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

        // Upcoming Events Button
        Positioned(
          top: screenHeight * 0.65,
          left: screenWidth * 0.223,
          child:
Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(2.0),
),
child: ElevatedButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
const updatedUpcoming.ScebUpdatedUpcomingEvent()),
);
},
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFF0B1AF2),
padding:
const EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0),
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