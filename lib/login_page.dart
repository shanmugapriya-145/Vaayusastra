import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart'; // Import HomePage
import 'register_page.dart'; // Import the RegisterPage

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '373930489357-7phikh95llrhnqo5fmpr7brak2jbl4mr.apps.googleusercontent.com',
    scopes: ['email'],
  );

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check login status on initialization
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // If user is logged in, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  Future<void> _saveLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Clear login state

    _googleSignIn.signOut(); // Sign out from Google Sign-In

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    var url = Uri.parse('http://localhost:3000/login');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}));

    if (response.statusCode == 200) {
      _saveLoginState();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      var jsonResponse = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'])),
      );
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      var url = Uri.parse('http://localhost:3000/google-login');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'idToken': googleAuth.idToken}));

      if (response.statusCode == 200) {
        _saveLoginState();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        var jsonResponse = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonResponse['message'])),
        );
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.blue[900],
                  fontFamily: 'OleoScript',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: _loginWithGoogle,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.account_circle, color: Colors.blue[900]),
                      SizedBox(width: 10),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(fontSize: 16, color: Colors.blue[900]),
                      ),
                    ],
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  side: BorderSide(color: Colors.blue[900]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Register now',
                      style: TextStyle(color: Colors.blue[900], fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
