import 'package:flutter/material.dart';
import 'catalog1.dart'; // Import Catalog1DetailPage
import 'catalog2.dart'; // Import Catalog2DetailPage
import 'catalog3.dart'; // Import Catalog3DetailPage
import 'catalog4.dart'; // Import Catalog4DetailPage

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 87, vertical: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[300]!, Colors.blue[900]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Explore Catalogs',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Roboto', // Use your preferred font family
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.blue[50], // Light blue background color, adjusted for clarity
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildCatalogItem(context, 'Catalog 1', Icons.book, Color.fromARGB(255, 6, 94, 182)),
                  _buildCatalogItem(context, 'Catalog 2', Icons.book, Color.fromARGB(255, 6, 94, 182)),
                  _buildCatalogItem(context, 'Catalog 3', Icons.book, Color.fromARGB(255, 6, 94, 182)),
                  _buildCatalogItem(context, 'Catalog 4', Icons.book, Color.fromARGB(255, 6, 94, 182)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatalogItem(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          _navigateToCatalogDetail(context, title); // Navigate to respective CatalogDetailPage
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 64,
                color: color,
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900], fontFamily: 'Roboto'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCatalogDetail(BuildContext context, String title) {
    // Navigate to respective CatalogDetailPage based on title
    Widget page;
    switch (title) {
      case 'Catalog 1':
        page = Catalog1DetailPage();
        break;
      case 'Catalog 2':
        page = Catalog2DetailPage();
        break;
      case 'Catalog 3':
        page = Catalog3DetailPage();
        break;
      case 'Catalog 4':
        page = Catalog4DetailPage();
        break;
      default:
        return; // Do nothing if the title doesn't match
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
