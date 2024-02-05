import 'package:calculator_app/provider/calculation_history_provider.dart';
import 'package:calculator_app/provider/theme_provider.dart';
import 'package:calculator_app/screen/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
// // import 'package:path_provider/path_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   await Hive.openBox<Map<String, String>>("calculator_history");
//   // final documentDir = await getApplicationDocumentsDirectory();
//   // Hive.init(documentDir.path);
//   runApp(const ProviderScope(child: MyApp()));
// }

// class MyApp extends ConsumerStatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   MyAppState createState() => MyAppState();
// }

// class MyAppState extends ConsumerState<MyApp> {
//   Color? themeColor;
//    void setThemeFromStorage() async {
//     await ref.watch(colorProvider).getColor().then((value) {
//       setState(() {
//         themeColor = value;
//       });
//     });
//   }
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Calculator App',
//       theme: ThemeData(
//         colorScheme: themeColor != null
//             ? ColorScheme.fromSeed(
//                 seedColor: themeColor!,
//               )
//             : null,
//       ),
//       home: themeColor == null
//           ? const CircularProgressIndicator()
//           : const Center(
//               child: CalculatorScreen(),
//             ),
//     );
//   }
// }

// import 'package:calculator_app/provider/theme_provider.dart';
// import 'package:calculator_app/screen/calculator_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<List<Map<String, String>>>('calculationHistory');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  Color? themeColor;
  void setThemeFromStorage() async {
    ref.watch(historyProvider).loadHistory();
    await ref.watch(colorProvider).getColor().then((value) {
      setState(() {
        themeColor = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (themeColor == null) setThemeFromStorage();
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
          ? const CircularProgressIndicator()
          : const Center(child: CalculatorScreen()),
    );
  }
}
