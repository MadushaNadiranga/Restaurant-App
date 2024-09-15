import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApprovetPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<ApprovetPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Map to track whether each order has been approved
  Map<String, bool> _approvalStatus = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No orders found.', style: TextStyle(color: Colors.white)),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var order = snapshot.data!.docs[index];

              // Check if 'foodPrice' field exists in the order document
              final foodPrice = order['foodPrice'] != null
                  ? (order['foodPrice'] as num).toDouble()
                  : 0.0;

              // Check if order has been approved
              bool isApproved = _approvalStatus[order.id] ?? false;

              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Implement cancel action here if needed
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  _firestore.collection('orders').doc(order.id).delete();
                },
                child: Card(
                  color: Colors.blue[200],
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text('${order['firstName']} ${order['lastName']}', style: TextStyle(color: Colors.black)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${order['address']}', style: TextStyle(color: Colors.black)),
                        Text('Email: ${order['email']}', style: TextStyle(color: Colors.black)),
                        Text('Mobile: ${order['mobileNumber']}', style: TextStyle(color: Colors.black)),
                        Text('Total: \$${foodPrice.toStringAsFixed(2)}', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    trailing: isApproved
                        ? Text(
                      'Approved',
                      style: TextStyle(color: Colors.green),
                    )
                        : ElevatedButton(
                      onPressed: () {
                        // Approve order and update UI
                        _approvalStatus[order.id] = true;
                        setState(() {});
                      },
                      child: Text('Approve'),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
