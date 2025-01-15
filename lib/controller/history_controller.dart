import 'dart:convert';
import 'package:notification/model/history_model.dart';
// import 'package:prrrrrr/models/history_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HistoryController {
  List<String>? list = []; // List to hold JSON strings for history entries
  List<History> historyList = []; // List to hold History objects
  static SharedPreferences? prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Read history entries from SharedPreferences
  List<History> read(String key) {
    try {
      // Clear previous lists to avoid duplicates
      historyList.clear();
      list!.clear();

      // Get the string list from SharedPreferences
      list!.addAll(prefs!.getStringList(key) ?? []);

      // Convert each JSON string back to a History object
      for (var item in list!) {
        historyList.add(History.fromMap(json.decode(item)));
      }
    } catch (e) {
      // Handle error if needed (e.g., logging)
    }

    return historyList; // Return the list of History objects
  }

  // Save history entries to SharedPreferences
  Future<void> save(String key, List<History> historyList) async {
    list!.clear(); // Clear the previous list

    // Encode each History object as JSON and add to the list
    for (var item in historyList) {
      list!.add(json.encode(item.toMap()));
    }

    // Save the list to SharedPreferences
    await prefs!.setStringList(key, list!);
  }
}
