import 'package:flutter/material.dart';
import 'course.dart';
import 'course_detail_page.dart';
import 'about_us_page.dart';
import 'dashboardpage.dart';
import 'payment_page.dart';
import 'login_page.dart';

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
    // Simulate logout by clearing shared preferences
    // You may replace this with actual logout logic
    // Clear login state
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
  // Define your featuredCourses list
  final List<Course> featuredCourses = [
    Course(
      name: 'Aerospace Engineering Fundamentals',
      description: 'Explore the basics of aerospace engineering',
      driveLink: 'https://drive.google.com/drive/folders/example1',
    ),
    Course(
     name: 'Advanced Aircraft Design',
      description:
          'Master the art of designing advanced aircraft and spacecraft',
      driveLink: 'https://drive.google.com/drive/folders/example2',
    ),
    Course(
      name: 'Space Mission Planning and Management',
      description:
          'Learn about planning, managing, and executing space missions',
      driveLink: 'https://drive.google.com/drive/folders/example3',
    ),
    // Add more courses as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[900]!, Colors.blue[600]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Welcome to Vaayusastra!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Discover the courses related to aerospace - We trigger the creative spark.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  'Explore Courses',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? Colors.blue[400]!
                      : Colors.blue[900]!;
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Featured Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredCourses.length, // Use featuredCourses.length
              itemBuilder: (context, index) {
                final course = featuredCourses[index]; // Access each course
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailPage(course: course),
                          ),
                        );
                      },
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              course.description,
                              style: TextStyle(fontSize: 14),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  // Add action if needed
                                },
                                child: Text('Learn More'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Latest Updates',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildUpdateItem(
                  title: 'Data Science Fundamentals',
                  description: 'Learn essential business skills, including management, marketing, finance, and strategic planning.',
                  date: 'June 25, 2024',
                ),
                SizedBox(height: 10),
                _buildUpdateItem(
                  title: 'Entrepreneurship and Innovation',
                  description: 'Explore entrepreneurship and innovation, including idea generation, startup funding, and business development.',
                  date: 'June 24, 2024',
                ),
                SizedBox(height: 10),
                _buildUpdateItem(
                  title: 'Digital Marketing Strategies',
                  description: 'Master digital marketing strategies, including SEO, social media marketing, content creation, and analytics.',
                  date: 'June 23, 2024',
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildUpdateItem({required String title, required String description, required String date}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 14),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Text(
              'Published on $date',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
