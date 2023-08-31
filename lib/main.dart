import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(
    MaterialApp(
      home: Calculator(),
    ),
  );
}
class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.green),
      home: SimpleCalculator(),
    );
  }
}
class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation="";
  String result="0";
  String expression="";
  double equationFontSize=38.0;
  double resultFontSize=48.0;
  buttonPressed(String buttonText) {
    setState(() {
      if(buttonText=="c") {
        equation="";
        result="0";
        equationFontSize=38.0;
        resultFontSize=48.0;
      }
      else if(buttonText=="⌦") {
        equationFontSize=38.0;
        resultFontSize=48.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation=="")
        {
          equation="0";
        }
      }
      else if(buttonText=="="){
        equationFontSize=38.0;
        resultFontSize=48.0;
        expression=equation;
        try {
          Parser p=Parser();
          Expression exp=p.parse(expression);
          ContextModel cm=ContextModel();
          result="${exp.evaluate(EvaluationType.REAL,cm)}";
        } catch(e) {
          result="Error";
        }
      }
      else {
        equationFontSize=38.0;
        resultFontSize=48.0;
        if(buttonText=="0")
        {
          equation=buttonText;
        }
        else {
          equation=equation+buttonText;
        }
      }
    });
  }
  Widget buildButton(String buttonText,double buttonHeight,Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height*.10*buttonHeight,
      color: buttonColor,
      child: Padding(
        padding:EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(
                  color: Colors.white24,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
          onPressed: () {
            buttonPressed(buttonText);
            equationFontSize=38.0;
            resultFontSize=48.0;
          },
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
          child: Text("simple calculator"),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text("${result}",style: TextStyle(fontSize: 38.0)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text("$equation",style: TextStyle(fontSize: 48.0),),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("c", 1, Colors.yellow),
                        buildButton("⌦", 1, Colors.blue),
                        buildButton("/", 1, Colors.red.shade200),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.black87),
                        buildButton("2", 1, Colors.black87),
                        buildButton("3", 1, Colors.black87),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black87),
                        buildButton("5", 1, Colors.black87),
                        buildButton("6", 1, Colors.black87),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black87),
                        buildButton("8", 1, Colors.black87),
                        buildButton("9", 1, Colors.black87),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.black87),
                        buildButton("0", 1, Colors.black87),
                        buildButton("00", 1, Colors.black87),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("*", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


