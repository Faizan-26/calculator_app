import 'package:calculator_app/screen/contants.dart';
import 'package:calculator_app/widgets/operator_button.dart';
import 'package:flutter/material.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Text("data"),
            // height: 80,
            // fallbackHeight: 5,
            // fallbackWidth: 50,
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return OperatorButton(
                    buttonText: Buttons[index],
                  );
                }),
          )
        ],
      ),
    );
  }
}
