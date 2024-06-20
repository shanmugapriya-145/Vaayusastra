import 'package:flutter/material.dart';
import 'payment_page.dart'; // Import PaymentPage
import 'course.dart'; // Assuming 'Course' class is defined in 'course.dart'

class CourseDetailPage extends StatelessWidget {
  final Course course; // Corrected to use 'Course' class

  CourseDetailPage({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
        backgroundColor: Colors.blue[900], // Dark blue app bar color
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[900]!, Colors.blue[600]!], // Gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              course.description,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _navigateToPaymentPage(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Button background color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPaymentPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
    );
  }
}
