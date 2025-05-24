class Event {
  final String title;
  final String date;
  final String timeIn;
  final int timeInPoints;
  final String timeOut;
  final int timeOutPoints;
  final bool completed;

  Event({
    required this.title,
    required this.date,
    required this.timeIn,
    required this.timeInPoints,
    required this.timeOut,
    required this.timeOutPoints,
    required this.completed,
  });

  factory Event.fromFirestore(Map<String, dynamic> data, {bool completed = false}) {
    return Event(
      title: data['title'] ?? '',
      date: data['date'] ?? '',
      timeIn: data['time_in'] ?? '',
      timeInPoints: data['time_in_points'] ?? 0,
      timeOut: data['time_out'] ?? '',
      timeOutPoints: data['time_out_points'] ?? 0,
      completed: completed,
    );
  }

  int get points => timeInPoints + timeOutPoints;
}
