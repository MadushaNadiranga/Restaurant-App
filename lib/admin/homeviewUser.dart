import 'package:flutter/material.dart';
import 'package:restaurant/admin/viewUsers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeviewUser(),
    );
  }
}

class HomeviewUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Panel',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFEABE6C)),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'USER',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow[700]),
              ),
            ),
          ),
          SizedBox(
            width: 150, // Custom card width
            height: 200, // Custom card height
            child: AdminCard(
              iconData: _getIconData(0),
              buttonText: 'READ',
              labelText: 'READ',
              onPressed: () => _handleButtonPressed(context, 0),
              cardColor: Color(0xFFFFEDD8),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(int index) {
    switch (index % 6) {
      case 0:
        return Icons.read_more;
      case 1:
        return Icons.add;
      case 2:
        return Icons.edit;
      case 3:
        return Icons.delete;
      default:
        return Icons.person;
    }
  }

  void _handleButtonPressed(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewData()),
    );
  }
}

class AdminCard extends StatelessWidget {
  final IconData iconData;
  final String buttonText;
  final String labelText;
  final VoidCallback onPressed;
  final Color cardColor;

  AdminCard({
    required this.iconData,
    required this.buttonText,
    required this.labelText,
    required this.onPressed,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, size: 50),
            SizedBox(height: 10),
            Text(labelText),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
