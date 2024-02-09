import 'package:calculator_app/contants/convertor_buttons.dart';
import 'package:calculator_app/widgets/convertor_buttons.dart';
import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key, required this.appbarName});
  final String appbarName;

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  void btnTaped(String s) {
    print(s);
  }

  void onLongPressedClear() {
    print('C');
  }

// !isNumeric()
//             ? Theme.of(context).colorScheme.inversePrimary
//             : Theme.of(context).colorScheme.primaryContainer,

  @override
  Widget build(BuildContext context) {
    Widget upperSection = Material(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: InkWell(
        onTap: () {
          print('Tapped');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(children: [
            Row(
              children: [
                Text(
                  "Kilometer",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Card(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Km",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "000",
                      overflow: TextOverflow.visible,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );

    Widget lowerSection = Material(
      child: InkWell(
        onTap: () {
          print('Tapped');
        },
        child: const Placeholder(
          fallbackHeight: 100,
        ),
      ),
    );
    Widget centralButton = Material(
      // this button is use to swap upper section with lower section
      child: InkWell(
        onTap: () {
          print('Tapped');
        },
        child: const Placeholder(
          fallbackHeight: 50,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.appbarName} Converter'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  upperSection,
                  const Placeholder(
                    fallbackHeight: 100,
                  ),
                  lowerSection
                ],
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.5, // make tiles size smaller

                      crossAxisCount: 3,
                    ),
                    itemCount: convertorButtons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ConvertorButton(
                          onLongPressedClear: onLongPressedClear,
                          buttonText: convertorButtons[index],
                          btnTaped: btnTaped,
                        ),
                      );
                    }),
              ))
        ],
      ),
    );
  }
}
