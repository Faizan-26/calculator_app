import 'package:calculator_app/screen/calc_screen.dart';
import 'package:calculator_app/screen/setting_screen.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.history_toggle_off)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.settings)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: const CalcScreen(),
    );
  }
}
