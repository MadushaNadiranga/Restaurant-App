import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class OrderForm extends StatefulWidget {
  final String foodName;
  final double foodPrice;

  OrderForm({
    required this.foodName,
    required this.foodPrice,
  });

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _address = '';
  String _email = '';
  String _mobileNumber = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Form',
          style: TextStyle(color: Color(0xFFFFEDD8)), // Adding text color here
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        hintText: 'Enter your first name',
                        filled: true,
                        fillColor: Colors
                            .blue[200], // Background color for text field
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _firstName = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  // Space between first name and last name fields
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        hintText: 'Enter your last name',
                        filled: true,
                        fillColor: Colors
                            .blue[200], // Background color for text field
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _lastName = value!;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Enter your address',
                  filled: true,
                  fillColor: Colors
                      .blue[200], // Background color for text field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Enter your email',
                  filled: true,
                  fillColor: Colors
                      .blue[200], // Background color for text field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Enter your mobile number',
                  filled: true,
                  fillColor: Colors
                      .blue[200], // Background color for text field
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _mobileNumber = value!;
                },
              ),
              SizedBox(height: 50.0),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _saveToFirestore();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFEDD8),
                  ),
                  child: Text('Place Order'),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Food Details:',
                  style: TextStyle(fontSize: 18.0, color: Colors.white)),
              SizedBox(height: 8.0),
              Text('Name: ${widget.foodName}',
                  style: TextStyle(color: Colors.white)),
              Text('Price: \$${widget.foodPrice.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  void _saveToFirestore() async {
    try {
      // Simulate order placement (replace with your actual logic)
      await _firestore.collection('orders').add({
        'firstName': _firstName,
        'lastName': _lastName,
        'address': _address,
        'email': _email,
        'mobileNumber': _mobileNumber,
        'foodName': widget.foodName,
        'foodPrice': widget.foodPrice,
      });

      // Send email confirmation
      await _sendConfirmationEmail();

      // Update UI or show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Order placed successfully! Confirmation email sent to $_email.'),
        duration: Duration(seconds: 5),
      ));
    } catch (e) {
      print('Error placing order: $e');
      // Handle error - show error message or alert dialog
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Order placed successfully!'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  Future<void> _sendConfirmationEmail() async {
    final Email email = Email(
      body: 'Your order for has been successfully placed.',
      subject: 'Order Confirmation',
      recipients: [_email], // User's email address
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      print('Confirmation email sent.');
    } catch (error) {
      print('Failed to send confirmation email: $error');
      throw error; // Rethrow the error to handle it in _saveToFirestore
    }
  }
}