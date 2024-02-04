
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorProvider extends ChangeNotifier {

Color _themeColor = const Color.fromARGB(255, 68, 138, 255);

  Color get color => _themeColor;

  void changeColor(Color color) {
    _themeColor = color;
    notifyListeners();
  }
}

final colorProvider = ChangeNotifierProvider<ColorProvider>((ref) {
  return ColorProvider();
});