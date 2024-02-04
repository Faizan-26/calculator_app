import 'package:calculator_app/provider/theme_provider.dart';
import 'package:calculator_app/screen/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPro = ref.watch(colorProvider).color;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorPro,
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}
