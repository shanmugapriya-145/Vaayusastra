import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeMessage(),
            SizedBox(height: 24),
            _buildHeaderCard(),
            SizedBox(height: 24),
            _buildFounderCard(),
            SizedBox(height: 24),
            _buildHowItWorksCard(),
            SizedBox(height: 24),
            _buildContactCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[300]!, Colors.blue[900]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'About Our Company:',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.blue[300]!, Colors.blue[900]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VAAYUSASTRA AEROSPACE',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 12),
              Text(
                'An Innovative Concept of Human Engineering',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Developing young talents through Aero Modelling workshops, science workshops for children, and theatre arts like storytelling. Providing internships and guidance for engineering students.',
                style: TextStyle(fontSize: 16, color: Colors.blue[900]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFounderCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.blue[300]!, Colors.blue[900]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CEO/Founder',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 12),
              Text(
                'G. JAGADEESH KANNA',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Jagadeesh Kanna, a versatile Indian talent, excels in stage acting, film direction, and lyrical prowess. As CEO of Vaayusastra Aerospace, he merges aeronautical knowledge with creative expression, democratizing aerospace understanding across India.',
                style: TextStyle(fontSize: 16, color: Colors.blue[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHowItWorksCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.blue[300]!, Colors.blue[900]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HOW IT WORKS',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Vaayusastra focuses on making aeronautical concepts accessible to children, young adults, and college students through:',
                style: TextStyle(fontSize: 16, color: Colors.blue[700]),
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBulletPoint('Hands-on science model making activities with mythological sci-fi stories'),
                  _buildBulletPoint('Theatrical enactments aligned with NCERT, CBSE, ICSE & NASA curriculum'),
                  _buildBulletPoint('Integrated training and internship programs for college students'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 16,
            color: Colors.blue[900],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.blue[500]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.blue[300]!, Colors.blue[900]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONTACT US',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Get in touch with us for more information or queries:',
                style: TextStyle(fontSize: 16, color: Colors.blue[700]),
              ),
              SizedBox(height: 12),
              _buildContactInfo('Head Office', '1st Floor, E Block, IITM Research Park, Kanagam Road, Tharamani, Chennai - 600113'),
              _buildContactInfo('Email', 'check-in@vaayusastra.com'),
              _buildContactInfo('Phone', '9360545176'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
        ),
        SizedBox(height: 4),
        Text(
          info,
          style: TextStyle(fontSize: 16, color: Colors.blue[500]),
        ),
      ],
    );
  }
}
