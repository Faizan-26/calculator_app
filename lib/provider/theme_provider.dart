import 'package:calculator_app/localstorage/theme_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorProvider extends ChangeNotifier {
  Future<Color> loadInitialColor() async {
    Color themeColor = await StoreTheme.loadThemeColor();
    return themeColor;
  }

  Color _themeColor = const Color.fromARGB(255, 68, 138, 255);

  Color get color {
    loadInitialColor();
    return _themeColor;
  }

  Future<Color> getColor() async {
    _themeColor = await loadInitialColor();
    return _themeColor;
  }

  void changeColor(Color color) {
    _themeColor = color;
    notifyListeners();
    StoreTheme.storeThemeColor(_themeColor);
  }
}

final colorProvider = ChangeNotifierProvider<ColorProvider>((ref) {
  return ColorProvider();
});
