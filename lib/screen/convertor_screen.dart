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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.appbarName} Converter'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Placeholder(
            fallbackHeight: 200,
          ),
          Expanded(
            flex: 1,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: convertorButtons.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConvertorButton(
                      onLongPressedClear: onLongPressedClear,
                      buttonText: convertorButtons[index],
                      btnTaped: btnTaped,
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
