import 'package:calculator_app/contants/convertor_buttons.dart';
import 'package:calculator_app/widgets/convertor_buttons.dart';
import 'package:flutter/material.dart';
// import 'package:units_converter/properties/length.dart';
// import 'package:units_converter/units_converter.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key, required this.currentUnitName});
  final String currentUnitName;

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  // AutomaticKeepAliveClientMixin is used to keep the state of the widget , before this is was causing infinte randering because prop is being passed by statefull widget and its parent is a gridview/listview
  String upperValue = "1";
  String lowerValue = "0";

  void btnTaped(String s) {
    // print(s);
  }

  void onLongPressedClear() {
    // print('C');
  }

  void getUnitData() {}

  bool toggleSwap = false; // this is used to swap upper and lower section

  @override
  Widget build(BuildContext context) {
    Widget upperSection = InkWell(
      onTap: () {
        // print('Tapped');
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
          const SizedBox(
            height: 24,
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
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        upperValue,
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );

    Widget lowerSection = InkWell(
      onTap: () {
        // print('Lower Section Tapped');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(children: [
          Row(
            children: [
              Text(
                "Meters",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(
            height: 24,
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
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        lowerValue,
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
    Widget centralButton = Material(
      // this button is use to swap upper section with lower section
      child: IconButton(
        icon: Icon(
          Icons.swap_vert,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          setState(() {
            String temp = upperValue; // restrict values to swap
            upperValue = lowerValue;
            lowerValue = temp;
            toggleSwap = !toggleSwap;
          });
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.currentUnitName} Converter'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Material(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: !toggleSwap ? upperSection : lowerSection,
                ),
                centralButton,
                Material(
                  child: toggleSwap ? upperSection : lowerSection,
                ),
              ],
            ),
          ),
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
