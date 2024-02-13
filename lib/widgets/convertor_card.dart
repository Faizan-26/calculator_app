// import 'package:calculator_app/contants/convertor_list.dart';
import 'package:calculator_app/contants/convertor_list.dart';
import 'package:calculator_app/screen/convertor_screen.dart';
import 'package:flutter/material.dart';

class ConverterCard extends StatelessWidget {
  const ConverterCard(
      {super.key, required this.name, required this.icon, required this.index});
  final int index;
  final String name;
  final IconData icon;

  void onTapFunc(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        maintainState: true,
        builder: (ctx) {
          print(
              "Navigatoing to converter screen"); // why this is being printed infinite times

          return ConverterScreen(
            currentUnitName: converterList[index]['name'],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapFunc(context);
      },
      child: Card(
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
      ),
    );
  }
}
