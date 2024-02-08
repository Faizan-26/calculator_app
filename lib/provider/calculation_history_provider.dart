import 'package:calculator_app/contants/calculation_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class HistoryNotifier extends ChangeNotifier {
  List<Map<String, String>> _calculationHistory = [];
  List<Map<String, String>> get history => _calculationHistory;
  Box? box;

  void addToHistory(String answer, String result) {
    _calculationHistory.add({
      'question': answer,
      'result': result,
    });
    storeHistory();
  }

  void storeHistory() async {
    if (box == null || !box!.isOpen) {
      box = Hive.box<List<Map<String, String>>>("calculationHistory");
    }
    await box!.put(historyKey, _calculationHistory);
    notifyListeners();
  }

  Future<void> clearAllHistory() async {
    _calculationHistory = [];
    if (box == null || !box!.isOpen) {
      box = Hive.box<List<Map<String, String>>>("calculationHistory");
    }
    box!.clear();
    notifyListeners();
  }

  void loadHistory() async {
    if (box == null || !box!.isOpen) {
      box = Hive.box<List<dynamic>>("calculationHistory");
    }
    final data = await box!.get(historyKey);
  
    List<Map<String, String>> convertedData = [];
    if (data == null) {
      return;
    }
    for (var item in data) {
      if (item != null && item is Map<dynamic, dynamic>) {
        String question = item['question'].toString();
        String result = item['result'].toString();
        convertedData.add({'question': question, 'result': result});
      }
    }
    _calculationHistory = convertedData;
    notifyListeners();
  }
}


final historyProvider = ChangeNotifierProvider<HistoryNotifier>((ref) {
  return HistoryNotifier();
});
