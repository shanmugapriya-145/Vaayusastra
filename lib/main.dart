import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart'; // Import SplashScreenWidget
// ignore: unused_import
import 'login_page.dart'; // Replace with your login page import
// ignore: unused_import
import 'home_page.dart'; // Replace with your home page import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Remove the debug label
      home: SplashScreenWidget(), // Show SplashScreenWidget initially
    );
  }
}
