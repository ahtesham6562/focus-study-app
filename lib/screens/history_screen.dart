import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification/controller/history_controller.dart';
import 'package:notification/model/history_model.dart';
// import 'package:prrrrrr/controllers/history_controller.dart';
// import 'package:prrrrrr/models/history_model.dart';
import 'package:notification/utils/colors.dart';
import 'package:notification/widgets/history_item.dart';
// import 'package:prrrrrr/widgets/history_item.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryController historyController = HistoryController();
  List<History> listHistory = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: green1));
    HistoryController.init();
    listHistory.addAll(historyController.read("history"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green2,
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: green1,
      ),
      body: SafeArea(
        child: listHistory.isEmpty
            ? Center(child: Text('No history available'))
            : ListView.builder(
          itemCount: listHistory.length,
          itemBuilder: (context, index) {
            return HistoryItem(history: listHistory[index]);
          },
        ),
      ),
    );
  }
}
