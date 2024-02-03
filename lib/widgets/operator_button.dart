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
      // padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
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



// InkWell(
//       // can also use gesture detector instead of inkwell but inkwell has ripple effect on tap
//       onTap: () {
//         selectCategory();
//       },
//       splashColor: Theme.of(context).colorScheme.onBackground,
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           gradient: LinearGradient(
//             colors: [
//               category.color.withOpacity(0.5),
//               category.color.withOpacity(0.95),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Text(
//           category.title,
//           style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                 color: Theme.of(context).colorScheme.onBackground,
//               ),
//         ),
//       ),
//     );