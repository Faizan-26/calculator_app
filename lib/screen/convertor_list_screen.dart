import 'package:calculator_app/contants/convertor_list.dart';
import 'package:calculator_app/screen/convertor_screen.dart';
import 'package:calculator_app/widgets/convertor_card.dart';
import 'package:flutter/material.dart';

class ConvertorListScreen extends StatelessWidget {
  const ConvertorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final converterGrid = converterList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converters List'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          int itemCount = constraints.maxWidth > 600 ? 3 : 2;
          itemCount = constraints.maxWidth > 1200 ? 4 : itemCount;
          return GridView.builder(
            itemCount: converterGrid.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: itemCount,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ConverterScreen(appbarName : converterGrid[index]['name'].toString() )));
                },
                child: ConverterCard(
                  name: converterGrid[index]['name'].toString(),
                  icon: converterGrid[index]['icon'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
