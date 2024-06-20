import 'package:flutter/material.dart';
import 'catalog1.dart'; // Import Catalog1DetailPage
import 'catalog2.dart'; // Import Catalog2DetailPage
import 'catalog3.dart'; // Import Catalog3DetailPage
import 'catalog4.dart'; // Import Catalog4DetailPage

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Dark blue app bar color
        elevation: 0, // No shadow
        title: Text('Explore Catalogs', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Color.fromARGB(255, 8, 74, 120), // Light blue background color
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCatalogItem(context, 'Catalog 1', Icons.book, Color.fromARGB(255, 49, 144, 239)),
            _buildCatalogItem(context, 'Catalog 2', Icons.book, Color.fromARGB(255, 49, 144, 239)),
            _buildCatalogItem(context, 'Catalog 3', Icons.book, Color.fromARGB(255, 49, 144, 239)),
            _buildCatalogItem(context, 'Catalog 4', Icons.book, Color.fromARGB(255, 49, 144, 239)),
          ],
        ),
      ),
    );
  }

  Widget _buildCatalogItem(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          _navigateToCatalogDetail(context, title); // Navigate to respective CatalogDetailPage
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
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
