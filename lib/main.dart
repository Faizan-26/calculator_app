import 'package:calculator_app/provider/theme_provider.dart';
import 'package:calculator_app/screen/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// class MyApp extends ConsumerWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     Color? themeColor = ref.watch(colorProvider).color;

//     themeColor = ref.watch(colorProvider).color;

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Calculator App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: themeColor,
//         ),
//       ),
//       home: const CalculatorScreen(),
//     );
//   }
// }

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  Color? themeColor;
  void setThemeFromStorage() async {
    await ref.watch(colorProvider).getColor().then((value) {
      setState(() {
        themeColor = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setThemeFromStorage();
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
