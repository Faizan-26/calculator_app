import 'package:flutter/material.dart';

class ConverterCard extends StatelessWidget {
  const ConverterCard({super.key, required this.name, required this.icon});

  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              color: Theme.of(context).primaryColor,
              icon,
              size: 30,
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
