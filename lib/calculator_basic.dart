import 'package:flutter/material.dart';
import 'package:uts_pemmob/bmi_calculator.dart';
import 'package:uts_pemmob/discount_calculator.dart';

class BasicCalculator extends StatefulWidget {
  const BasicCalculator({super.key});

  @override
  _BasicCalculatorState createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "*") {
        _output = (num1 * num2).toString();
      } else if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      _output += buttonText;
    }

    setState(() {
      output = double.parse(_output).toString();
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Biasa'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu Kalkulator',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Kalkulator Biasa'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: const Text('Kalkulator BMI'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BMICalculator()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.percent),
              title: const Text('Kalkulator Diskon'),
              onTap: () {
                // Tambahkan navigasi ke halaman Diskon
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DiscountCalculator()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*"),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: [
                  buildButton("."),
                  buildButton("0"),
                  buildButton("C"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: [
                  buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
