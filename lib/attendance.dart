import 'package:attendance_app/home_page.dart';
import 'package:flutter/material.dart';

const bgColor = Color(0xff0b1af2);

class Event {
  final String title;
  final String date;
  final String day;
  final String loginTime;
  final String logoutTime;
  final int points;
  final bool completed;

  Event({
    required this.title,
    required this.date,
    required this.day,
    required this.loginTime,
    required this.logoutTime,
    required this.points,
    required this.completed,
  });
}

class Attendance extends StatelessWidget {
  Attendance({super.key});

  final List<Event> events = [
    Event(
      title: "Acquaintance Party",
      date: "07-02-24",
      day: "Thursday",
      loginTime: "8:00 AM",
      logoutTime: "Missed",
      points: 100,
      completed: false,
    ),
    Event(
      title: "SMCTI Orientation",
      date: "07-10-24",
      day: "Wednesday",
      loginTime: "9:00 AM",
      logoutTime: "12:00 PM",
      points: 80,
      completed: true,
    ),
    Event(
      title: "Welcome Seminar",
      date: "07-12-24",
      day: "Friday",
      loginTime: "10:00 AM",
      logoutTime: "1:00 PM",
      points: 100,
      completed: true,
    ),
    Event(
      title: "Student Assembly",
      date: "07-15-24",
      day: "Monday",
      loginTime: "8:30 AM",
      logoutTime: "11:30 AM",
      points: 100,
      completed: true,
    ),
    Event(
      title: "Team Building",
      date: "07-20-24",
      day: "Saturday",
      loginTime: "9:00 AM",
      logoutTime: "Missed",
      points: 300,
      completed: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalPoints = events.fold(0, (sum, e) => sum + e.points);
    final earnedPoints = events.where((e) => e.completed).fold(0, (sum, e) => sum + e.points);
    final completedEvents = events.where((e) => e.completed).length;
    final missedEvents = events.length - completedEvents;
    final completedPercent = events.isEmpty ? "0%" : "${((completedEvents / events.length) * 100).toStringAsFixed(0)}%";
    final missedPercent = events.isEmpty ? "0%" : "${((missedEvents / events.length) * 100).toStringAsFixed(0)}%";

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('images/leading-icon.png', width: 24, height: 24),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeContent()),
            );
          },
        ),
        title: const Text("Attendance Dashboard", style: TextStyle(fontFamily: 'Poppins')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset('images/SMCTI LOGO.png', height: 150),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff5059f1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text("Attendance Summary",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatBox("$totalPoints", "Total Points"),
                      _buildStatBox("$earnedPoints", "Points Earned"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatusBox("Completed", completedPercent, Colors.green),
                      _buildStatusBox("Missed", missedPercent, Colors.red),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Event History",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 12),
            ...events.map((event) => _buildEventCard(event)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins')),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Poppins')),
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
          Text("${event.date} (${event.day})", style: const TextStyle(fontSize: 14, fontFamily: 'Poppins')),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Login: ${event.loginTime}", style: const TextStyle(fontSize: 14)),
              Text("Logout: ${event.logoutTime}", style: TextStyle(fontSize: 14, color: event.logoutTime == 'Missed' ? Colors.red : Colors.black)),
              Text("${event.points} pts", style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}
