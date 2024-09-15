import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:restaurant/admin/menuPage.dart';
import 'package:restaurant/admin/cartPage.dart';
import 'package:restaurant/profile/profilePage.dart';

class HomePage extends StatelessWidget {
  final FirebaseFirestore _firestoreService = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Tastopia",
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'DancingScript',
              color: Colors.yellow[700],
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo1.jpg', // Provide your logo asset path here
            width: 40, // Adjust width as needed
            height: 40, // Adjust height as needed
          ),
        ),
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {
        //     // Handle menu button press
        //   },
        // ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.notifications, color: Colors.yellow[700]),
            onSelected: (String value) {
              // Handle menu item selection here
              if (value == 'option1') {
                // Handle option 1
              } else if (value == 'option2') {
                // Handle option 2
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'option1',
                child: Text('No Notification Right Now'),
              ),
              PopupMenuItem<String>(
                value: 'option2',
                child: Text(''),
              ),
              // Add more PopupMenuItems as needed
            ],
            offset: Offset(0, 40), // Adjust the vertical offset as needed
            color: Colors.grey.withOpacity(0.7), // Set the menu color to transparent
            elevation: 0, // Set the elevation to 0 to remove shadow
            padding: EdgeInsets.zero, // Remove default padding
          )

        ],
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 40.0,
                child: TextField(
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
                      onPressed: () {
                        // Handle search action
                      },
                    ),
                  ),
                ),

              ),
              SizedBox(height: 16.0),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeInOut,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  // Show only one item at a time
                  aspectRatio: 16 / 9,
                ),
                items: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/slider1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/slider2.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/slider3.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Center(
                  child: Text(
                    "MENU",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Blending-rgjzK',
                      color: Colors.yellow[700],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 16.0),
                    Container(
                      width: 120.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your on-pressed functionality here.
                        },
                        child: Text('Breakfast'),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      width: 120.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your on-pressed functionality here.
                        },
                        child: Text('Lunch'),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      width: 120.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your on-pressed functionality here.
                        },
                        child: Text('Dinner'),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      width: 120.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your on-pressed functionality here.
                        },
                        child: Text('All'),
                      ),
                    ),
                    SizedBox(width: 16.0),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Popular Menu For Breakfast',
                      style: TextStyle(fontSize: 18, color: Colors.yellow[800],fontFamily: 'Blending-rgjzK'),
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(
                                      notesStream: _firestoreService.collection('menu').snapshots(),
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/menu/breakfast/Soup.jpg'),
                                    radius: 50,
                                  ),
                                  SizedBox(height: 8), // Add some spacing between the image and text
                                  Text(
                                    'Soup',
                                    style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                  ), // You can customize this text as needed
                                ],
                              ),
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(
                                      notesStream: _firestoreService.collection('menu').snapshots(),
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/menu/breakfast/Egg Toast.jpg'),
                                    radius: 50,
                                  ),
                                  SizedBox(height: 8), // Add some spacing between the image and text
                                  Text(
                                    'Bread',
                                    style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                  ), // You can customize this text as needed
                                ],
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/menu/breakfast/Pancake.jpg'),
                                  radius: 50,
                                ),
                                SizedBox(height: 8), // Add some spacing between the image and text
                                Text('Pancake',
                                  style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                ), // You can customize this text as needed
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/menu/breakfast/Salad.jpg'),
                                  radius: 50,
                                ),
                                SizedBox(height: 8), // Add some spacing between the image and text
                                Text('Salad',
                                  style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                ), // You can customize this text as needed
                              ],
                            ),
                          ),


                          SizedBox(width: 20),
                        ],
                      ),

                    ),






                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Popular Menu For Lunch',
                      style: TextStyle(fontSize: 18, color: Colors.yellow[800],fontFamily: 'Blending-rgjzK'),
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/menu/lunch/caesar.jpg'),
                                  radius: 50,
                                ),
                                SizedBox(height: 8),
                                Text('Caesar',
                                  style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/menu/lunch/greek-salad.jpg'),
                                  radius: 50,
                                ),
                                SizedBox(height: 8),
                                Text('Salad',
                                  style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/menu/lunch/Chicken Rice.jpg'),
                                  radius: 50,
                                ),
                                SizedBox(height: 8),
                                Text('Chicken Rice',
                                  style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/menu/lunch/salmon.jpg'),
                                  radius: 50,
                                ),
                                SizedBox(height: 8),
                                Text('Salmon',
                                  style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Popular Menu For Dinner',
                      style: TextStyle(fontSize: 18, color: Colors.yellow[800],fontFamily: 'Blending-rgjzK'),
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/menu/dinner/pizza.jpg'),
                                  radius: 50,
                                ),
                                SizedBox(height: 8),
                                Text('Pizza',
                                  style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/menu/dinner/Barbecue chicken.jpg'),
                                  radius: 50,
                                ),
                                SizedBox(height: 8),
                                Text('Barbecue',
                                  style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/menu/dinner/Fried Rice.jpg'),
                                  radius: 50,
                                ),
                                SizedBox(height: 8),
                                Text('Fried Rice',
                                  style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/menu/dinner/spagathi.jpg'),
                                  radius: 50,
                                ),
                                SizedBox(height: 8),
                                Text('spagathi',
                                  style: TextStyle(fontSize: 15, color: Color(0xFFFFEDD8)),

                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => MenuPage()),
                        // );
                      },
                      child: Text('View All'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Center(
                  child: Text(
                    "OFFERS",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Blending-rgjzK',
                      color: Colors.yellow[700],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeInOut,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  // Show only one item at a time
                  aspectRatio: 16 / 9,
                  scrollDirection:
                  Axis.vertical, // Change sliding direction
                ),

                items: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/offer/4.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/offer/5.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/offer/3.jpg'),
                        fit: BoxFit.cover,
                      ),

                    ),

                  ),

                ],

              ),
              // SizedBox(height: 16.0),
              // SizedBox(
              //   width: 80.0, // Adjust the height as per your requirement
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Add your button functionality here
              //     },
              //     child: Text('Your Button'),
              //   ),
              // ),

            ],

          ),

        ),

      ),












      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: PreferredSize(
          preferredSize: Size.fromHeight(60), // Adjust the height as needed
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
                        color: Colors.white, // Set your desired text color
                        fontSize: 10.0, // Set your desired font size
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
                        color: Colors.white, // Set your desired text color
                        fontSize: 10.0, // Set your desired font size
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuPage(
                        notesStream: _firestoreService.collection('menu').snapshots(),
                      ),
                    ),
                  );
                },
              ),


              IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.account_circle, color: Colors.yellow[700]),
                    Text(
                      'PROFILE',
                      style: TextStyle(
                        color: Colors.white, // Set your desired text color
                        fontSize: 10.0, // Set your desired font size
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },

              ),

              IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.yellow[700]),
                    Text(
                      'ODERS',
                      style: TextStyle(
                        color: Colors.white, // Set your desired text color
                        fontSize: 10.0, // Set your desired font size
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),


              IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.more, color: Colors.yellow[700]),
                    Text(
                      'MORE',
                      style: TextStyle(
                        color: Colors.white, // Set your desired text color
                        fontSize: 10.0, // Set your desired font size
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  // Add your onPressed logic here
                },

              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(String itemName, String imagePath) {
    return Container(
      width: 120,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(itemName),
        ],
      ),
    );
  }
}

