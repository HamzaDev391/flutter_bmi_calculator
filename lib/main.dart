import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Your first screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Pro App',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // This launches your login screen
    );
  }
}
