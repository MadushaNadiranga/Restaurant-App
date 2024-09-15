import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import 'package:restaurant/user/homePage.dart'; // Import your home page
import 'package:restaurant/admin/mainadmin.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import Flutter SVG package

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = ''; // To display error messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SIGN IN",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8, // 80% of the available width
          heightFactor: 0.6,
          child: Card(
            color: Colors.white.withOpacity(0.2), // Transparent card
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "WELLCOME BACK.!", // Title text
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Blending-rgjzK',

                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_emailController.text == 'admin@gmail.com' && _passwordController.text == 'admin123') {
                            adminSignIn(); // Admin sign in
                          } else {
                            signIn(); // Regular user sign in
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all<double>(3), // Elevation for normal state
                          overlayColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.6)), // Color when button is pressed
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 50.0,
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Center( // Center the column
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Equal spacing between children
                      children: [
                        SvgPicture.asset(
                          'assets/svg/apple.svg',
                          width: 500.0,
                          height: 50.0,
                        ),
                        SvgPicture.asset(
                          'assets/svg/facebook.svg',
                          width: 50.0,
                          height: 50.0,
                        ),
                        SvgPicture.asset(
                          'assets/svg/google.svg',
                          width: 50.0,
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Clear the navigation stack and replace the current page with the home page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false, // Prevent going back to the sign-in page
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid email or password'; // Set error message
      });
    }
  }

  void adminSignIn() async {
    try {
      // Admin login
      // Navigate to admin panel
      // For now, let's just print a message
      print('Admin login successful');
      // You can navigate to the admin panel page here
      // Clear the navigation stack and replace the current page with the admin home page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AdminPanelPage()),
            (route) => false, // Prevent going back to the sign-in page
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid email or password'; // Set error message
      });
    }
  }
}
