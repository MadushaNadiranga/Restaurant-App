import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/user/homePage.dart';
import 'package:restaurant/guest/cartPage.dart';
import 'firestore.dart';

class MenuPage extends StatefulWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> notesStream;

  const MenuPage({Key? key, required this.notesStream}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late TextEditingController _searchController;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _filteredNotesStream;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredNotesStream = widget.notesStream; // Initialize with the original stream
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(color: Color(0xFFFFEDD8)), // Adding text color here
        ),
        backgroundColor: Colors.black,
      ),

      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 40.0,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for a restaurant',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: _performSearch,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'MENU',
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontFamily: 'Blending-rgjzK',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Add your menu items widgets here
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _filteredNotesStream, // Use the filtered stream here
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> notesList =
                      snapshot.data!.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot<Map<String, dynamic>> document =
                      notesList[index];

                      Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                      String imageUrl = data['imageUrl'] ?? '';
                      String noteText = data['note'] ?? '';
                      double price = (data['price'] ?? 0).toDouble();

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            noteText,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '\$${price.toStringAsFixed(2)}',
                                            style: TextStyle(color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 110,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.add_shopping_cart, color: Colors.red),
                                    onPressed: () {
                                      CartPage.addItemToCart(noteText, price, imageUrl);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('$noteText added to cart'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
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
                  // No action needed as we're already on the menu page
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

  void _performSearch() {
    String query = _searchController.text.trim();
    setState(() {
      // Update the filtered stream
      _filteredNotesStream = FirestoreService().getFilteredNotesStream(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
