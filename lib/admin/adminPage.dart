import 'package:flutter/material.dart';
import 'package:restaurant/admin/homePage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminPage(),
    );
  }
}

class AdminPage extends StatelessWidget {
  final List<String> cardTexts = [
    'READ',
    'ADD',
    'UPDATE',
    'DELETE',
  ];

  final List<String> buttonTexts = [
    'READ',
    'ADD',
    'UPDATE',
    'DELETE',
  ];


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
                'FOOD',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow[700]),
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10, // Horizontal spacing between items
            mainAxisSpacing: 10, // Vertical spacing between items
            padding: EdgeInsets.all(10), // Padding around the grid
            children: List.generate(4, (index) {
              Color cardColor = Color(0xFFFFEDD8);
              return SizedBox(
                width: 150, // Custom card width
                height: 150, // Custom card height
                child: AdminCard(
                  iconData: _getIconData(index),
                  buttonText: buttonTexts[index],
                  labelText: cardTexts[index], // Different text for each card
                  onPressed: () => _handleButtonPressed(context, index), // Different function for each button
                  cardColor: cardColor, // Pass card color
                ),
              );
            }),
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
    // Define different actions for each button
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        break;
    }
  }
}

class AdminCard extends StatelessWidget {
  final IconData iconData;
  final String buttonText;
  final String labelText;
  final VoidCallback onPressed;
  final Color cardColor; // New property to hold card color

  AdminCard({
    required this.iconData,
    required this.buttonText,
    required this.labelText,
    required this.onPressed,
    required this.cardColor, // Initialize card color
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor, // Set card color
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, size: 50), // Icon
            SizedBox(height: 10),
            Text(labelText), // Text
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ), // Button
          ],
        ),
      ),
    );
  }
}