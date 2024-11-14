import 'package:flutter/material.dart';
import 'package:uts_pemmob/converter_data.dart';

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String? _selectedUnit = "Celsius";
  String? _targetUnit = "Fahrenheit";
  double _inputValue = 0;
  String _result = "";

  void _convert() {
    double convertedValue;
    if (_selectedUnit == "Celsius" && _targetUnit == "Fahrenheit") {
      convertedValue = (_inputValue * 9 / 5) + 32;
    } else if (_selectedUnit == "Fahrenheit" && _targetUnit == "Celsius") {
      convertedValue = (_inputValue - 32) * 5 / 9;
    } else {
      convertedValue = _inputValue; // Default if units are the same
    }

    setState(() {
      _result = "$convertedValue $_targetUnit";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Temperatur'),
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
                'Menu Konversi',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Konversi Data'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DataConverter()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: const Text('Konversi Temperatur'),
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
              decoration: const InputDecoration(labelText: 'Masukkan Nilai'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _inputValue = double.tryParse(value) ?? 0;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedUnit,
                    items: ["Celsius", "Fahrenheit"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedUnit = newValue;
                      });
                    },
                  ),
                ),
                const Icon(Icons.arrow_forward),
                Expanded(
                  child: DropdownButton<String>(
                    value: _targetUnit,
                    items: ["Celsius", "Fahrenheit"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _targetUnit = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Konversi'),
            ),
            const SizedBox(height: 20),
            Text(
              'Hasil: $_result',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
