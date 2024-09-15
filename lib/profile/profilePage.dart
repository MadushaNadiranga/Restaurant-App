import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/guest/homePage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  final picker = ImagePicker();
  late User? _user; // Firebase user
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_user != null) {
      // Fetch user details from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(_user!.uid).get();
      if (snapshot.exists) {
        setState(() {
          _nameController.text = snapshot.get('name') ?? '';
          _phoneNumberController.text = snapshot.get('phoneNumber') ?? '';
          _addressController.text = snapshot.get('address') ?? '';
        });
      }
    }
  }

  Future<void> _saveUserData() async {
    if (_user != null) {
      await FirebaseFirestore.instance.collection('users').doc(_user!.uid).set({
        'name': _nameController.text,
        'phoneNumber': _phoneNumberController.text,
        'address': _addressController.text,
      }, SetOptions(merge: true));
    }
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PROFILE',
          style: TextStyle(color: Color(0xFFFFEDD8)), // Adding text color here
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(

          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: getImage,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[900],
                      ),
                    ),
                    _profileImage != null
                        ? CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.transparent,
                      backgroundImage: FileImage(_profileImage!),
                    )
                        : Icon(
                      Icons.account_circle,
                      size: 120,
                      color: Colors.grey[600],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[800],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.white),
                        // Remove underline
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Perform action when edit icon is pressed
                      // For example, you can enable editing for the respective field
                      // Here, I'm just printing a message
                      print('Edit Name');
                    },
                    icon: Icon(Icons.edit, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: _saveUserData,
                    icon: Icon(Icons.save, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(text: _user?.email ?? ''),
                      readOnly: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        // Remove underline
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _phoneNumberController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.white),
                        // Remove underline
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Perform action when edit icon is pressed
                      // For example, you can enable editing for the respective field
                      // Here, I'm just printing a message
                      print('Edit Phone Number');
                    },
                    icon: Icon(Icons.edit, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: _saveUserData,
                    icon: Icon(Icons.save, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _addressController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(color: Colors.white),
                        // Remove underline
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Perform action when edit icon is pressed
                      // For example, you can enable editing for the respective field
                      // Here, I'm just printing a message
                      print('Edit Address');
                    },
                    icon: Icon(Icons.edit, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: _saveUserData,
                    icon: Icon(Icons.save, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              // Logout Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),

        ),

      );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
