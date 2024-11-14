import 'package:flutter/material.dart';
import 'package:uts_pemmob/bmi_calculator.dart';
import 'package:uts_pemmob/calculator_basic.dart';

class DiscountCalculator extends StatefulWidget {
  const DiscountCalculator({super.key});

  @override
  _DiscountCalculatorState createState() => _DiscountCalculatorState();
}

class _DiscountCalculatorState extends State<DiscountCalculator> {
  double _originalPrice = 0.0;
  double _discountPercent = 0.0;
  String _result = "";

  void _calculateDiscount() {
    if (_originalPrice > 0 && _discountPercent > 0) {
      double discountAmount = _originalPrice * (_discountPercent / 100);
      double finalPrice = _originalPrice - discountAmount;
      setState(() {
        _result =
            "Diskon: Rp ${discountAmount.toStringAsFixed(2)}\nHarga Akhir: Rp ${finalPrice.toStringAsFixed(2)}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Diskon'),
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
                Navigator.pop(context);
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
              decoration: const InputDecoration(labelText: "Harga Asli (Rp)"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _originalPrice = double.tryParse(value) ?? 0.0;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Diskon (%)"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _discountPercent = double.tryParse(value) ?? 0.0;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateDiscount,
              child: const Text('Hitung Diskon'),
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
