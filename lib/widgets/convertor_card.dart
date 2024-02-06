// import 'package:flutter/material.dart';

// class ConverterCard extends StatelessWidget {

// final String name;
// final IconData icon;
//   @override
//   Widget build(BuildContext context) {
// return Card(
//   child: Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       children: [
//         // Add your converter UI elements here
//       ],
//     ),
//   ),
// );
//   }
// }

import 'package:flutter/material.dart';

class ConverterCard extends StatelessWidget {
  const ConverterCard({super.key, required this.name, required this.icon});

  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              color: Theme.of(context).primaryColor,
              icon,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
