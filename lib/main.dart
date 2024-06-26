import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import "splash_screen.dart"; // Import SplashScreenWidget
import 'login_page.dart'; // Import LoginPage
import 'home_page.dart'; // Import HomePage
import 'onboarding_screen.dart'; // Import OnboardingScreen

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
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/onboarding': (context) => OnboardingScreen(),
      },
    );
  }
}


class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay for the splash screen

    final prefs = await SharedPreferences.getInstance();
    bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (onboardingComplete) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash.jpg'),
      ),
    );
  }
}
