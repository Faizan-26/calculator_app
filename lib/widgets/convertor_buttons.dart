import 'package:flutter/material.dart';

class ConvertorButton extends StatelessWidget {
  const ConvertorButton(
      {super.key,
      required this.buttonText,
      required this.btnTaped,
      required this.onLongPressedClear});

  final void Function() onLongPressedClear;
  final String buttonText;
  final void Function(String s) btnTaped;
  bool isNumeric() {
    return double.tryParse(buttonText) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 1,
      margin: const EdgeInsets.all(4),
      child: Material(
        color: !isNumeric()
            ? Theme.of(context).colorScheme.inversePrimary
            : Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          splashColor: Theme.of(context)
              .colorScheme
              .onSurface, // Change the splash color here

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
      ),
    );
  }
}
