import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EventCardsList extends StatelessWidget {
  final String collectionName;
  final bool showAttendButton;

  const EventCardsList({
    Key? key,
    required this.collectionName,
    this.showAttendButton = false,
  }) : super(key: key);

String formatDate(dynamic dateField) {
  if (dateField == null) return 'No date';

  try {
    if (dateField is Timestamp) {
      final dateTime = dateField.toDate();
      return DateFormat('MMMM dd, yyyy').format(dateTime); // May 23, 2025
    } else if (dateField is String) {
      // Try to parse manually if stored as string like "05/23/2025"
      final parsedDate = DateFormat('MM/dd/yyyy').parse(dateField);
      return DateFormat('MMMM dd, yyyy').format(parsedDate); // May 23, 2025
    }
  } catch (e) {
    return 'Invalid date';
  }

  return 'Unknown date';
}


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(collectionName)
          .orderBy('date', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading events'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return const Center(child: Text('No events found'));
        }

        final doc = docs.first;
        final data = doc.data()! as Map<String, dynamic>;

        final date = formatDate(data['date']);
        final timeIn = data['time_in'] ?? 'No start time';
        final timeOut = data['time_out'] ?? 'No end time';
        final title = data['title'] ?? 'No title';

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Container(
                  width: 430,
                  height: 180,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  date,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.access_time, color: Colors.white, size: 16),
                              const SizedBox(width: 5),
                              Text(
                                "Time In: $timeIn",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.access_time, color: Colors.white, size: 16),
                              const SizedBox(width: 5),
                              Text(
                                "Time Out: $timeOut",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (showAttendButton)
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/success');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF0B1AF2),
                              minimumSize: const Size(100, 30),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
            ],
          ),
        );
      },
    );
  }
}
