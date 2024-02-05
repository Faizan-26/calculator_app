import 'package:calculator_app/provider/calculation_history_provider.dart';
import 'package:calculator_app/provider/theme_provider.dart';
import 'package:calculator_app/screen/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<List<dynamic>>('calculationHistory');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  Color? themeColor;
  void setThemeFromStorage() {
    ref.watch(colorProvider).getColor().then((value) {
      themeColor = value;
    });
  }

  @override
  void initState() {
    super.initState();
    ref.read(historyProvider).loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(colorProvider).getColor().then((value) {
      themeColor = value;
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: themeColor != null
            ? ColorScheme.fromSeed(
                seedColor: themeColor!,
              )
            : null,
      ),
      home: themeColor == null
          ? const Center(child: CircularProgressIndicator())
          : const Center(child: CalculatorScreen()),
    );
  }
}
