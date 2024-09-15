import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/user/homePage.dart';
import 'package:restaurant/admin/oderform.dart';

class CartPage extends StatefulWidget {
  static List<Map<String, dynamic>> cartItems = [];

  @override
  _CartPageState createState() => _CartPageState();

  static void addItemToCart(String itemName, double price, String imageUrl) {
    cartItems.add({'name': itemName, 'price': price, 'image': imageUrl, 'quantity': 1});
  }

  static void removeItemFromCart(int index) {
    cartItems.removeAt(index);
  }
}

class _CartPageState extends State<CartPage> {
  void increaseQuantity(int index) {
    setState(() {
      CartPage.cartItems[index]['quantity'] ??= 1;
      CartPage.cartItems[index]['quantity']++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (CartPage.cartItems[index]['quantity'] != null &&
          CartPage.cartItems[index]['quantity'] > 1) {
        CartPage.cartItems[index]['quantity']--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      CartPage.removeItemFromCart(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CART',
          style: TextStyle(color: Color(0xFFFFEDD8)), // Adding text color here
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Container(
          //   height: 40.0,
          //   child: TextField(
          //     decoration: InputDecoration(
          //       hintText: 'Search for a restaurant',
          //       contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          //       filled: true,
          //       fillColor: Colors.grey[300],
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10.0),
          //         borderSide: BorderSide.none,
          //       ),
          //       suffixIcon: IconButton(
          //         icon: Icon(Icons.search),
          //         onPressed: () {},
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: CartPage.cartItems.length,
              itemBuilder: (context, index) {
                double totalPrice = (CartPage.cartItems[index]['price'] ?? 0) * (CartPage.cartItems[index]['quantity'] ?? 0);


                return Dismissible(
                  key: Key(CartPage.cartItems[index]['name']),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    removeItem(index);
                  },
                  child: Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CartPage.cartItems[index]['name'],
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${totalPrice.toStringAsFixed(2)}', // Display total price
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      decreaseQuantity(index);
                                    },
                                  ),
                                  Text(
                                    ' ${CartPage.cartItems[index]['quantity'] ?? 1}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      increaseQuantity(index);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      leading: Image.network(CartPage.cartItems[index]['image']),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderForm(
                                foodName: CartPage.cartItems[index]['name'],
                                foodPrice: CartPage.cartItems[index]['price'],
                                // Pass user information here if needed
                              ),
                            ),
                          );
                          print("Placing order for ${CartPage.cartItems[index]['name']}");
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFEDD8)),
                        ),
                        child: Text('Place Order'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),


      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.home, color: Colors.yellow[700]),
                    Text(
                      'HOME',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.restaurant_menu, color: Colors.yellow[700]),
                    Text(
                      'MENU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
              ),
              IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.account_circle, color: Colors.yellow[700]),
                    Text(
                      'PROFILE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  // Add your profile logic here
                },
              ),
              IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.yellow[700]),
                    Text(
                      'ORDERS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  // No action needed as we're already on the cart page
                },
              ),
              IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.more, color: Colors.yellow[700]),
                    Text(
                      'MORE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  // Add your more logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CartPage(),
  ));
}
