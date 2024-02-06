import 'package:calculator_app/contants/convertor_list.dart';
import 'package:calculator_app/widgets/convertor_card.dart';
import 'package:flutter/material.dart';

class ConvertorListScreen extends StatelessWidget {
  const ConvertorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converters'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          int itemCount = constraints.maxWidth > 600 ? 3 : 2;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: itemCount,
            ),
            itemBuilder: (context, index) {
              return ConverterCard(
                name: converterList[index]['name'],
                icon: converterList[index]['icon'],
              );
            },
          );
        },
      ),
    );
  }
}
