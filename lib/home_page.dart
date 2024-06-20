import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_us_page.dart';
import 'dashboardpage.dart'; // Import DashboardPage
import 'payment_page.dart'; // Import PaymentPage
import 'login_page.dart'; // Import LoginPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    AboutUsPage(),
    DashboardPage(), // Use DashboardPage for Courses
  ];

  void onTabTapped(int index) {
    if (index < _children.length) {
      setState(() {
        _currentIndex = index;
      });
    } else {
      // Show the popup menu for the "More" option
      _showMoreOptions();
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _selectMoreOption('Payment');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _logout();
              },
            ),
          ],
        );
      },
    );
  }

  void _selectMoreOption(String choice) {
    switch (choice) {
      case 'Payment':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentPage()),
        );
        break;
      // Handle other options as needed
    }
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Clear login state

    // Navigate to LoginPage and clear the navigation stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false, // Clear all routes on stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blue[900], // Darker blue color for app bar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      backgroundColor: Colors.blue[50], // Set background color to pastel blue
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue[900], // Darker blue for selected item
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'Home Page!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
