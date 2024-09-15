import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewData extends StatelessWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white, // change your color here
        ),
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: EdgeInsets.all(16.0),
            children: snapshot.data!.docs.map((document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  color: Colors.white.withOpacity(0.2),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      'Username: ${data['username']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Email: ${data['email']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    // You can customize how you want to display each data item here
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
