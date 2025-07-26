import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  final String userName;
  final int age;
  final double bmi;

  const ReportScreen({
    super.key,
    required this.userName,
    required this.age,
    required this.bmi,
  });

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.lightBlue.shade100;
    if (bmi < 25) return Colors.green.shade200;
    if (bmi < 30) return Colors.orange.shade200;
    return Colors.red.shade200;
  }

  @override
  Widget build(BuildContext context) {
    String category = _getBMICategory(bmi);
    Color bgColor = _getBMIColor(bmi);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Report'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hello, $userName!',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'Age: $age',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 20),
                Text(
                  'Your BMI is:',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  bmi.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'Category: $category',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
