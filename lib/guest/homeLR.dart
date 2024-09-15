import 'package:flutter/material.dart';
import 'package:restaurant/guest/signInPage.dart';
import 'package:restaurant/guest/signUpPage.dart';

class HomeLR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Color(0xFFFFEDD8)), // Adding text color here
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.yellow[700],
                fontWeight: FontWeight.bold,
                fontFamily: 'Blending-rgjzK',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              'T A S T O P I A',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.yellow[700],
                fontWeight: FontWeight.bold,
                fontFamily: 'Blending-rgjzK',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );

              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                backgroundColor: Color(0xFFFFEDD8),
              ),
              child: Text(
                'SIGN IN',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );

              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                backgroundColor: Color(0xFFFFEDD8),
              ),
              child: Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
