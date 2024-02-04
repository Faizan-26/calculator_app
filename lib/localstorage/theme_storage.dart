import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreTheme {
  static const themeColorKey = "calculator_theme";
  static const Color defaultTheme = Color.fromARGB(255, 68, 138, 255);

  static Future<void> storeThemeColor(Color color) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(themeColorKey, color.value);
  }

  static Future<Color> loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(themeColorKey) ?? defaultTheme.value;
    return Color(colorValue);
  }
}

// class StoreCalculatorHistory {
//   static const historyKey = "calculator_history";

  
// }
