import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'login_page.dart'; // Ensure this import is correct and LoginPage is defined
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  late TapGestureRecognizer _loginRecognizer;

  @override
  void initState() {
    super.initState();
    _loginRecognizer = TapGestureRecognizer()..onTap = _navigateToLogin;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _loginRecognizer.dispose();
    super.dispose();
  }

  Future<void> _register(BuildContext context) async {
    String name = _nameController.text;
    String email = _emailController.text;
    String dob = _dobController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String phoneNumber = _phoneNumberController.text;

    if (password != confirmPassword) {
      _showSnackBar(context, 'Passwords do not match');
      return;
    }

    var url = Uri.parse('http://192.168.1.6:3000/register'); // Replace with your server's IP
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'dob': dob,
          'password': password,
          'phoneNumber': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        var jsonResponse = json.decode(response.body);
        _showSnackBar(context, jsonResponse['message']);
      }
    } catch (e) {
      print('Error registering user: $e');
      _showSnackBar(context, 'An error occurred while registering. Please try again later.');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: GoogleFonts.raleway(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.blue[700]!.withOpacity(0.5),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.blue[700]!.withOpacity(0.5),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.blue[700]!.withOpacity(0.5),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today, color: Colors.white),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            _dobController.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  readOnly: true,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.blue[700]!.withOpacity(0.5),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.blue[700]!.withOpacity(0.5),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.blue[700]!.withOpacity(0.5),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _register(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Sign Up',
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
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        recognizer: _loginRecognizer,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
