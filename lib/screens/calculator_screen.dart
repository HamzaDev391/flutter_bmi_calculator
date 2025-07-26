import 'package:flutter/material.dart';
import 'report_screen.dart';

class CalculatorScreen extends StatefulWidget {
  final String userName;
  final int age;

  const CalculatorScreen({super.key, required this.userName, required this.age});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _weightUnit = 'kg';
  String _heightUnit = 'cm';

  final List<String> _weightUnits = ['kg', 'lbs'];
  final List<String> _heightUnits = ['cm', 'ft', 'in'];

  double? _bmi;

  void _calculateBMI() {
    double? weight = double.tryParse(_weightController.text.trim());
    double? height = double.tryParse(_heightController.text.trim());

    if (weight == null || height == null) {
      _showError('Please enter valid numbers for weight and height.');
      return;
    }

    if (_weightUnit == 'lbs') {
      weight *= 0.453592;
    }

    double heightInMeters;
    if (_heightUnit == 'cm') {
      heightInMeters = height / 100;
    } else if (_heightUnit == 'ft') {
      heightInMeters = height * 0.3048;
    } else {
      heightInMeters = height * 0.0254;
    }

    setState(() {
      _bmi = weight! / (heightInMeters * heightInMeters);
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportScreen(
          userName: widget.userName,
          age: widget.age,
          bmi: _bmi!,
        ),
      ),
    );
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Input Error"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK", style: TextStyle(color: Colors.blue)),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  Widget _buildLabeledInput({
    required String label,
    required Icon icon,
    required TextEditingController controller,
    required List<String> units,
    required String currentUnit,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: icon,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IntrinsicWidth(
          child: DropdownButtonFormField<String>(
            value: currentUnit,
            items: units.map((unit) {
              return DropdownMenuItem(value: unit, child: Text(unit));
            }).toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildLabeledInput(
              label: 'Weight',
              icon: const Icon(Icons.monitor_weight),
              controller: _weightController,
              units: _weightUnits,
              currentUnit: _weightUnit,
              onChanged: (value) => setState(() => _weightUnit = value!),
            ),
            const SizedBox(height: 20),
            _buildLabeledInput(
              label: 'Height',
              icon: const Icon(Icons.height),
              controller: _heightController,
              units: _heightUnits,
              currentUnit: _heightUnit,
              onChanged: (value) => setState(() => _heightUnit = value!),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text(
                'Calculate',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
