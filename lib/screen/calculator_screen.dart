import 'package:calculator_app/provider/calculation_history_provider.dart';
import 'package:calculator_app/screen/calc_screen.dart';
import 'package:calculator_app/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, String>> calculationHistory =
        ref.watch(historyProvider).history;
    final sizedBoxMaxHeight = MediaQuery.of(context).size.height - 350;
    final sizedBoxMinHeight = calculationHistory.length * 70.0;
    print("Calculation History $calculationHistory");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'History',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: sizedBoxMinHeight > sizedBoxMaxHeight
                                ? sizedBoxMaxHeight
                                : sizedBoxMinHeight,
                            child: calculationHistory.isEmpty
                                ? const Center(
                                    child: Text("Do some calculations!"),
                                  )
                                : ListView.builder(
                                    itemCount: calculationHistory.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(calculationHistory[index]
                                            ['question']!),
                                        subtitle: Text(calculationHistory[index]
                                            ["result"]!),
                                      );
                                    },
                                  ),
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              ref.watch(historyProvider).clearAllHistory();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Clear")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Close")),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.history_toggle_off)),
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
