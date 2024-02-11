// import 'package:calculator_app/contants/convertor_list.dart';
import 'package:calculator_app/contants/convertor_list.dart';
import 'package:calculator_app/screen/convertor_screen.dart';
import 'package:flutter/material.dart';

class ConverterCard extends StatefulWidget {
  const ConverterCard(
      {super.key, required this.name, required this.icon, required this.index});
  final int index;
  final String name;
  final IconData icon;

  @override
  State<ConverterCard> createState() => _ConverterCardState();
}

class _ConverterCardState extends State<ConverterCard> {
  Future<void> onTapFunc() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Builder(builder: (context) {
        return ConverterScreen(
          currentUnitName: converterList[widget.index]['name'].toString(),
        );
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunc,
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
                widget.icon,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.name,
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
