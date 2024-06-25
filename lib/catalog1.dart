import 'package:flutter/material.dart';
import 'course_detail_page.dart'; // Import CourseDetailPage
import 'payment_page.dart'; // Import PaymentPage
import 'course.dart'; // Import Course class from course.dart

class Catalog1DetailPage extends StatefulWidget {
  @override
  _Catalog1DetailPageState createState() => _Catalog1DetailPageState();
}

class _Catalog1DetailPageState extends State<Catalog1DetailPage> {
  Offset _position = Offset(0, 0); // Default initial position for the chat button
  List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final List<Course> _courses = [
    Course(
      name: 'Aerospace Engineering Fundamentals',
      description:
          'Explore the basics of aerospace engineering, focusing on principles of flight, aerodynamics, and spacecraft design.',
      driveLink: 'https://drive.google.com/drive/folders/example1', // Add drive link
    ),
    Course(
      name: 'Advanced Aircraft Design',
      description:
          'Master the art of designing advanced aircraft and spacecraft, including materials, structures, and propulsion systems.',
      driveLink: 'https://drive.google.com/drive/folders/example2', // Add drive link
    ),
    Course(
      name: 'Space Mission Planning and Management',
      description:
          'Learn about planning, managing, and executing space missions, including satellite launches and space exploration.',
      driveLink: 'https://drive.google.com/drive/folders/example3', // Add drive link
    ),
  ];

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(text: 'How may I assist you?', isBot: true));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      setState(() {
        _position = Offset(screenWidth - 70, screenHeight - 150); // Initial position at bottom right
      });
    });
  }

  void _showChatInterface(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Chat with us!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: _messages[index].isBot
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: _messages[index].isBot
                              ? Colors.grey[300]
                              : Colors.blue[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _messages[index].text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Type your message',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: _handleUserMessage,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        _handleUserMessage(_textController.text);
                      }
                    },
                    child: Text('Send'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleUserMessage(String message) {
    setState(() {
      _messages.add(ChatMessage(text: message, isBot: false));
      _textController.clear();
      _provideBotResponse(message);
    });
  }

  void _provideBotResponse(String message) {
    String response;
    if (message.toLowerCase().contains('payment')) {
      response = 'We accept credit card, debit card, and PayPal.';
    } else if (message.toLowerCase().contains('courses')) {
      response = 'We offer courses in Aerospace Engineering, Aircraft Design, and Space Mission Planning.';
    } else if (message.toLowerCase().contains('support')) {
      response = 'Our support team is available 24/7.';
    } else if (message.toLowerCase().contains('pricing')) {
      response = 'Our pricing plans are designed to fit different budgets.';
    } else {
      response = 'Apologies, I\'m not sure how to respond to that.';
    }

    Future.delayed(Duration(milliseconds: 700), () {
      setState(() {
        _messages.add(ChatMessage(text: response, isBot: true));
      });
    });
  }

  void _navigateToPaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
    );
  }

  void _navigateToCourseDetailPage(Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CourseDetailPage(course: course)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aerospace Courses'),
        backgroundColor: Colors.blue[900], // Dark blue app bar color
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: _courses.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _courses[index].name,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _courses[index].description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _navigateToCourseDetailPage(_courses[index]);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900], // Button background color
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Rounded corners
                              foregroundColor: Colors.white, // Text color
                            ),
                            child: Text('View Details'),
                          ),
                          ElevatedButton(
                            onPressed: _navigateToPaymentPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 68, 7, 130), // Button background color
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Rounded corners
                              foregroundColor: Colors.white, // Text color
                            ),
                            child: Text('Buy Now'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: Draggable(
              feedback: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.chat),
              ),
              child: FloatingActionButton(
                onPressed: () {
                  _showChatInterface(context);
                },
                child: Icon(Icons.chat),
              ),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                setState(() {
                  _position = offset;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isBot;

  ChatMessage({required this.text, required this.isBot});
}

void main() {
  runApp(MaterialApp(
    home: Catalog1DetailPage(),
  ));
}
