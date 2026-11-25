import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static const String historyKey = 'game_history';

  Future<void> insertHistory(int guess, String result) async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> history = await getHistory();

    history.insert(0, {
      'id': DateTime.now().millisecondsSinceEpoch,
      'guess': guess,
      'result': result,
    });

    await prefs.setString(historyKey, jsonEncode(history));
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(historyKey);

    if (data == null) return [];

    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }
}
