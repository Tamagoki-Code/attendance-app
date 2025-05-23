import 'package:attendance_app/sceb_update.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScebUpdatedRecentEvent extends StatefulWidget {
  const ScebUpdatedRecentEvent({super.key});

  @override
  _ScebUpdatedRecentEventState createState() => _ScebUpdatedRecentEventState();
}

class _ScebUpdatedRecentEventState extends State<ScebUpdatedRecentEvent> {
  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeInController = TextEditingController();
  final TextEditingController timeOutController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTimeIn;
  TimeOfDay? selectedTimeOut;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectTime({required bool isTimeIn}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isTimeIn
          ? (selectedTimeIn ?? TimeOfDay.now())
          : (selectedTimeOut ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isTimeIn) {
          selectedTimeIn = picked;
          timeInController.text = picked.format(context);
        } else {
          selectedTimeOut = picked;
          timeOutController.text = picked.format(context);
        }
      });
    }
  }

  void _updateEvent() async {
    if (eventTitleController.text.isEmpty ||
        selectedDate == null ||
        selectedTimeIn == null ||
        selectedTimeOut == null) {
      Fluttertoast.showToast(msg: "Please fill in all fields.");
      return;
    }

    final eventData = {
      'title': eventTitleController.text,
      'date': DateFormat('MM/dd/yyyy').format(selectedDate!),
      'time_in': selectedTimeIn!.format(context),
      'time_out': selectedTimeOut!.format(context),
      'updated_at': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('recent_events').add(eventData);
      Fluttertoast.showToast(msg: "Event updated successfully.");
      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to update event: $e");
    }
  }

  @override
  void dispose() {
    eventTitleController.dispose();
    dateController.dispose();
    timeInController.dispose();
    timeOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.white)),
          Positioned(
            top: -98,
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
            bottom: -70,
            left: -5,
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
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SCEBUpdate(),
                  ),
                );
              },
              child: Image.asset(
                'assets/ic-back.png',
                height: screenHeight * 0.05,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.15,
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: eventTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Event Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _selectDate,
                  child: AbsorbPointer(
                    child: TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: "Date",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Image.asset(
                            'images/date-icon.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectTime(isTimeIn: true),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: timeInController,
                            decoration: InputDecoration(
                              labelText: "Time In",
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Image.asset(
                                  'images/clock-icon.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectTime(isTimeIn: false),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: timeOutController,
                            decoration: InputDecoration(
                              labelText: "Time Out",
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Image.asset(
                                  'images/clock-icon.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B1AF2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _updateEvent,
                    child: const Text(
                      "Update Event",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
