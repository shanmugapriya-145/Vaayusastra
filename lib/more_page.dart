import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Option 1'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Option 2'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Option 3'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Option 4'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
