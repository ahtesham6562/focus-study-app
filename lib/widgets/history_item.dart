import 'package:flutter/material.dart';
import 'package:notification/model/history_model.dart';
// import 'package:prrrrrr/models/history_model.dart';
import 'package:notification/utils/colors.dart';

class HistoryItem extends StatelessWidget {
  final History history;

  const HistoryItem({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate minutes and seconds
    int minutes = history.focusedSecs ~/ 60; // Integer division for minutes
    int seconds = history.focusedSecs % 60; // Remainder for seconds

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        title: Text(history.purpose),
        subtitle: Text('Time focused: $minutes minutes ${seconds.toString().padLeft(2, '0')} seconds'), // Format display
        trailing: Text(history.dateTime.toLocal().toString().split(' ')[0]),
      ),
    );
  }
}
