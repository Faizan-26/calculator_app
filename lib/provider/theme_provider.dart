import 'package:calculator_app/localstorage/theme_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorProvider extends ChangeNotifier {
  Future<Color> loadInitialColor() async {
    Color themeColor = await StoreTheme.loadThemeColor();
    notifyListeners();
    return themeColor;
  }

  Color? _themeColor;

  Color get color {
    loadInitialColor();
    while (_themeColor != null) {
      if (_themeColor != null) {
        return _themeColor!;
      }
    }
    return _themeColor!;
    // return _themeColor;
  }

  Future<Color> getColor() async {
    _themeColor = await loadInitialColor();
    notifyListeners();
    return _themeColor!;
  }

  void changeColor(Color color) {
    _themeColor = color;
    StoreTheme.storeThemeColor(_themeColor!);
    notifyListeners();
  }
}

final colorProvider = ChangeNotifierProvider<ColorProvider>((ref) {
  return ColorProvider();
});
