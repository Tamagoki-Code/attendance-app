import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'event.dart'; // Your Event model with fromFirestore method
import 'home_page.dart'; // Your actual homepage widget

const bgColor = Color(0xff0b1af2);

class Attendance extends StatelessWidget {
  Attendance({super.key});

  // Fetch events from 3 Firestore collections
  Future<List<Event>> fetchEvents() async {
    List<String> collections = ['events', 'recent_events', 'upcoming_events'];
    List<Event> events = [];

    for (String col in collections) {
      final snapshot = await FirebaseFirestore.instance.collection(col).get();
      for (var doc in snapshot.docs) {
        // Parse Firestore doc data to Event
        events.add(Event.fromFirestore(doc.data()));
      }
    }

    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('images/leading-icon.png', width: 24, height: 24),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomeContent())),
        ),
        title: const Text("Attendance Dashboard", style: TextStyle(fontFamily: 'Poppins')),
      ),
      body: FutureBuilder<List<Event>>(
        future: fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());

          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return const Center(child: Text('No events available', style: TextStyle(color: Colors.white)));

          final events = snapshot.data!;

          // Calculate summary stats
          final totalPoints = events.fold(0, (sum, e) => sum + e.points);
          final earnedPoints = events.where((e) => e.completed).fold(0, (sum, e) => sum + e.points);
          final completedEvents = events.where((e) => e.completed).length;
          final missedEvents = events.length - completedEvents;
          final completedPercent = events.isEmpty ? "0%" : "${((completedEvents / events.length) * 100).toStringAsFixed(0)}%";
          final missedPercent = events.isEmpty ? "0%" : "${((missedEvents / events.length) * 100).toStringAsFixed(0)}%";

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset('images/SMCTI LOGO.png', height: 150),
                const SizedBox(height: 16),
                _buildSummary(totalPoints, earnedPoints, completedPercent, missedPercent),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Event History",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ...events.map(_buildEventCard).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummary(int total, int earned, String completed, String missed) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff5059f1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            "Attendance Summary",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatBox("$total", "Total Points"),
              _buildStatBox("$earned", "Points Earned"),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatusBox("Completed", completed, Colors.green),
              _buildStatusBox("Missed", missed, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Poppins'),
        ),
      ],
    );
  }

  Widget _buildStatusBox(String label, String percent, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: color),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: Text(percent, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          )
        ],
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(event.title,
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: event.completed ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  event.completed ? "Completed" : "Missed",
                  style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(event.date, style: const TextStyle(fontSize: 14, fontFamily: 'Poppins')),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Login: ${event.timeIn}", style: const TextStyle(fontSize: 14)),
              Text(
                "Logout: ${event.timeOut}",
                style: TextStyle(
                  fontSize: 14,
                  color: event.timeOut.toLowerCase() == 'missed' ? Colors.red : Colors.black,
                ),
              ),
              Text("${event.points} pts", style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
