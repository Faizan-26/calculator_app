import 'package:hive/hive.dart';

class CalculatorHistory {
  Box? _historyBox;

  
  void storeHistory() {
    Hive.openBox("calculator_history").then((box) {
      _historyBox = box;
    });
  }
}
