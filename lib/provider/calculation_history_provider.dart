import 'package:calculator_app/contants/calculation_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class HistoryNotifier extends ChangeNotifier {
  List<Map<String, String>> _calculationHistory = [];

  List<Map<String, String>> get history => _calculationHistory;

  void addToHistory(String answer, String result) {
    _calculationHistory.add({
      'question': answer,
      'result': result,
    });
    storeHistory();
  }

  void storeHistory() async {
    var box =
        await Hive.openBox<List<Map<String, String>>>("calculator_history");
    await box.put(historyKey, _calculationHistory);
    box.close();
  }

  void clearAllHistory() async {
    print("CLEARING");
    _calculationHistory = [];
    var box =
        await Hive.openBox<List<Map<String, String>>>("calculator_history");
    await box.clear();
    box.close();
  }

  void loadHistory() async {
    var box = await Hive.openBox("calculator_history");
    final data = box.get(historyKey, defaultValue: <dynamic>[]);

    List<Map<String, String>> convertedData = [];

    for (var item in data) {
      if (item != null && item is Map<dynamic, dynamic>) {
        String question = item['question'].toString();
        String result = item['result'].toString();
        convertedData.add({'question': question, 'result': result});
      }
    }

    _calculationHistory = convertedData;
    notifyListeners();
    box.close();
    // print("Loaded $_calculationHistory");
  }
}

final historyProvider = ChangeNotifierProvider<HistoryNotifier>((ref) {
  return HistoryNotifier();
});
