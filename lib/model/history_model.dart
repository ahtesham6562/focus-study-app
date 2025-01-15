class History {
  DateTime dateTime; // To store when the timer was used
  int focusedSecs;   // To store the focused time in seconds
  String purpose;    // To store the purpose of the timer

  History({
    required this.dateTime,
    required this.focusedSecs,
    required this.purpose,
  });

  // Convert a History object to a map for storage
  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.toIso8601String(), // Convert DateTime to ISO string
      'focusedSecs': focusedSecs,
      'purpose': purpose,
    };
  }

  // Create a History object from a map
  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      dateTime: DateTime.parse(map['dateTime']),
      focusedSecs: map['focusedSecs'],
      purpose: map['purpose'],
    );
  }
}
