import 'package:flutter/material.dart';

class OperatorButton extends StatelessWidget {
  const OperatorButton(
      {super.key,
      required this.buttonText,
      required this.btnTaped,
      required this.onLongPressedClear});
  final void Function() onLongPressedClear;
  final String buttonText;
  final void Function(String s) btnTaped;
  bool isNumeric() {
    try {
      double.parse(buttonText);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: !isNumeric()
            ? Theme.of(context).colorScheme.inversePrimary
            : Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        splashColor: Colors.red, // Change the splash color here
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          btnTaped(buttonText);
        },
        onLongPress: () {
          if (buttonText == 'C') {
            onLongPressedClear();
          }
        },
        child: Center(
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
      ),
    );
  }
}

