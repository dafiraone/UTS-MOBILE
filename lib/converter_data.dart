import 'package:flutter/material.dart';
import 'package:uts_pemmob/converter_temperature.dart';

class DataConverter extends StatefulWidget {
  const DataConverter({super.key});

  @override
  _DataConverterState createState() => _DataConverterState();
}

class _DataConverterState extends State<DataConverter> {
  String? _selectedUnit = "Bytes";
  String? _targetUnit = "Kilobytes";
  double _inputValue = 0;
  String _result = "";

  void _convert() {
    // Conversion factors to Bytes
    Map<String, double> unitToBytes = {
      "Bytes": 1,
      "Kilobytes": 1024,
      "Megabytes": 1024 * 1024,
      "Gigabytes": 1024 * 1024 * 1024,
    };

    // Ensure the input units exist in the map
    if (unitToBytes.containsKey(_selectedUnit) &&
        unitToBytes.containsKey(_targetUnit)) {
      double sourceFactor = unitToBytes[_selectedUnit]!;
      double targetFactor = unitToBytes[_targetUnit]!;

      // Perform the conversion
      double convertedValue = (_inputValue * sourceFactor) / targetFactor;

      setState(() {
        _result = "$convertedValue $_targetUnit";
      });
    } else {
      setState(() {
        _result = "Error: Invalid unit selection!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Besaran Data'),
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: const Text('Konversi Temperatur'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TemperatureConverter()));
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
                    items: ["Bytes", "Kilobytes", "Megabytes", "Gigabytes"]
                        .map((String value) {
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
                    items: ["Bytes", "Kilobytes", "Megabytes", "Gigabytes"]
                        .map((String value) {
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
