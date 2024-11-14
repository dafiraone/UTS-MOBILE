import 'package:flutter/material.dart';
import 'package:uts_pemmob/calculator_basic.dart';
import 'package:uts_pemmob/discount_calculator.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double _height = 0.0;
  double _weight = 0.0;
  String _result = "";

  void _calculateBMI() {
    if (_height > 0 && _weight > 0) {
      double bmi = _weight / ((_height / 100) * (_height / 100));
      setState(() {
        if (bmi < 18.5) {
          _result = "Underweight (BMI: ${bmi.toStringAsFixed(2)})";
        } else if (bmi < 24.9) {
          _result = "Normal (BMI: ${bmi.toStringAsFixed(2)})";
        } else if (bmi < 29.9) {
          _result = "Overweight (BMI: ${bmi.toStringAsFixed(2)})";
        } else {
          _result = "Obese (BMI: ${bmi.toStringAsFixed(2)})";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator BMI'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BasicCalculator()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: const Text('Kalkulator BMI'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.percent),
              title: const Text('Kalkulator Diskon'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DiscountCalculator()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration:
                  const InputDecoration(labelText: "Masukkan Tinggi (cm)"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _height = double.tryParse(value) ?? 0.0;
              },
            ),
            TextField(
              decoration:
                  const InputDecoration(labelText: "Masukkan Berat (kg)"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _weight = double.tryParse(value) ?? 0.0;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: const Text('Hitung BMI'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
