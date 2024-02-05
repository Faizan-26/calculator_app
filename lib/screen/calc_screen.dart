import 'package:calculator_app/provider/calculation_history_provider.dart';
import 'package:calculator_app/screen/contants.dart';
import 'package:calculator_app/widgets/operator_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

class CalcScreen extends ConsumerStatefulWidget {
  const CalcScreen({super.key});

  @override
  ConsumerState<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends ConsumerState<CalcScreen> {
  String writtenExpression = "";
  String resultExpression = "0";
  int pointCount = 0;
  void evaluatedExpression() {
    try {
      Parser p = Parser();

      // Replace square root expressions with equivalent power expressions
      resultExpression = resultExpression.replaceAllMapped(
          RegExp(r'(\d+\.?\d*)√(\d+\.?\d*)'),
          (match) => '${match.group(1)} * (${match.group(2)})^0.5');

      resultExpression = resultExpression.replaceAllMapped(
          RegExp(r'√(\d+\.?\d*)'), (match) => '(${match.group(1)})^0.5');

      // Parse and evaluate the expression
      Expression exp = p.parse(resultExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Format the result
      String result =
          eval.toStringAsFixed(eval.truncateToDouble() == eval ? 0 : 2);

      // Replace power expressions back to original square root expressions
      resultExpression = resultExpression.replaceAllMapped(
          RegExp(r'1\*\((\d+\.?\d*)\)\^0.5'), (match) => '√${match.group(1)}');

      resultExpression = resultExpression.replaceAllMapped(
          RegExp(r'(\d+\.?\d*) \* √(\d+\.?\d*)'),
          (match) => '${match.group(1)} * √${match.group(2)}');
      // Add to history and update state
      ref.watch(historyProvider).addToHistory(resultExpression, result);
      setState(() {
        writtenExpression = resultExpression;
        resultExpression = result;
      });
    } catch (e) {
      setState(() {
        resultExpression = "Error";
      });
    }
  }

  bool isNumeric(String ch) {
    return double.tryParse(ch) != null;
  }

  void btnTaped(String s) {
    HapticFeedback.lightImpact();
    if (resultExpression == "Error") {
      if (s == "C") {
        setState(() {
          resultExpression = "0";
        });
      } else {
        setState(() {
          resultExpression = s;
        });
      }
      return;
    }
    // if (s == "C") {
    //   resultExpression =
    //       resultExpression.substring(0, resultExpression.length - 1);
    //   return;
    // }
    if (s == "=") {
      evaluatedExpression();
      return;
    }

    if (s == ".") {
      pointCount++;
    }
    if (pointCount == 2) {
      pointCount--;
      return;
    }
    // print("Written expresion $resultExpression and $s");
    bool isCurrentSymbolOperator = s == "+" ||
        s == "-" ||
        s == "×" ||
        s == "÷" ||
        s == "/" ||
        s == "^" ||
        s == "%";
    if (isCurrentSymbolOperator) {
      pointCount = 0;
    }
    bool isLastCharacterOperator =
        resultExpression[resultExpression.length - 1] == "+" ||
            resultExpression[resultExpression.length - 1] == "-" ||
            resultExpression[resultExpression.length - 1] == "*" ||
            resultExpression[resultExpression.length - 1] == "/" ||
            // resultExpression[resultExpression.length - 1] == "√" ||
            resultExpression[resultExpression.length - 1] == "^" ||
            resultExpression[resultExpression.length - 1] == "%";
    if (isLastCharacterOperator && isCurrentSymbolOperator) {
      return;
    }
    if (s == "√") {
      // if last character is a number then add * 1 * √ before the square root else add 1 * √
      // suggest code here
      if (resultExpression.isNotEmpty) {
        if (isNumeric(resultExpression[resultExpression.length - 1]) &&
            resultExpression[resultExpression.length - 1] != "0") {
          s = "*1*√";
        } else {
          s = "1*√";
        }
      }
    }
    if (isCurrentSymbolOperator) {
      pointCount = 0;
    }
    if (resultExpression.length == 1 && s != ".") {
      if (resultExpression == "0") {
        resultExpression = "";
      }
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
    pointCount = 0;
    HapticFeedback.heavyImpact();
    setState(() {
      writtenExpression = "";
      resultExpression = "0";
    });
  }

  @override
  void dispose() {
    super.dispose();
    ref.watch(historyProvider).storeHistory();
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
