import 'package:calculator_app/screen/contants.dart';
import 'package:calculator_app/widgets/operator_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  String writtenExpression = "";
  String resultExpression = "0";

  void evaluatedExpression() {
    try {
      Parser p = Parser();

      resultExpression = resultExpression.replaceAllMapped(
          RegExp(r'(\d+)√(\d+)'),
          (match) => '${match.group(1)} * √${match.group(2)}');

      resultExpression = resultExpression.replaceAllMapped(
          RegExp(r'√(\d+)'), (match) => '${match.group(1)}^0.5');
      Expression exp = p.parse(resultExpression);

      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      String result = eval.toString();
      if (result.endsWith(".0")) {
        result = result.substring(0, result.length - 2);
      }
      resultExpression = resultExpression.replaceAllMapped(
          RegExp(r'(\d+)\^0.5'), (match) => '√${match.group(1)}');
      resultExpression = resultExpression.replaceAllMapped(
          RegExp(r'(\d+) \* √(\d+)'),
          (match) => '${match.group(1)}√${match.group(2)}');

      setState(() {
        writtenExpression = resultExpression;
        resultExpression = result;
      });
    } catch (e) {
      // do nothing
    }
  }

  void btnTaped(String s) {
    HapticFeedback.lightImpact();
    if (resultExpression.length == 1 && s != ".") {
      if (resultExpression == "0") {
        resultExpression = "";
      }
    }
    if (s == "=") {
      evaluatedExpression();
      return;
    }
    if (s == "C") {
      if (resultExpression.isNotEmpty) {
        setState(() {
          resultExpression =
              resultExpression.substring(0, resultExpression.length - 1);
        });
      }
    } else {
      if (s == "×") {
        s = "*";
      } else if (s == "÷") {
        s = "/";
      }
      setState(() {
        resultExpression += s;
      });
    }
    if (resultExpression.isEmpty) {
      resultExpression = "0";
    }
  }

  void onLongPressedClear() {
    HapticFeedback.heavyImpact();
    setState(() {
      writtenExpression = "";
      resultExpression = "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(writtenExpression),
                    const SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        resultExpression,
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return OperatorButton(
                    onLongPressedClear: onLongPressedClear,
                    buttonText: Buttons[index],
                    btnTaped: btnTaped,
                  );
                }),
          )
        ],
      ),
    );
  }
}
