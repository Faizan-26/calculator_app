import 'package:calculator_app/contants/convertor_list.dart';
// import 'package:calculator_app/screen/convertor_screen.dart';
// import 'package:calculator_app/screen/temp_screen.dart';
import 'package:calculator_app/widgets/convertor_card.dart';
import 'package:flutter/material.dart';

class ConvertorListScreen extends StatelessWidget {
  const ConvertorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, dynamic>> converterGrid = converterList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converters List'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          int crossItemCount = constraints.maxWidth > 600 ? 3 : 2;
          crossItemCount = constraints.maxWidth > 1200 ? 4 : crossItemCount;
          return GridView.builder(
            itemCount: converterGrid.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossItemCount,
            ),
            itemBuilder: (context, index) {
              return ConverterCard(
                index: index,
                name: converterGrid[index]['name'].toString(),
                icon: converterGrid[index]['icon'],
              );
            },
          );
        },
      ),
    );
  }
}
