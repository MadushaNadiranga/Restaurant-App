import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              // Navigate to the dashboard page
            },
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Inventory'),
            onTap: () {
              // Navigate to the inventory page
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
            onTap: () {
              // Navigate to the search page
            },
          ),
          ListTile(
            leading: Icon(Icons.qr_code),
            title: Text("'00'"),
            onTap: () {
              // Navigate to the '00' page
            },
          ),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text('✡'),
            onTap: () {
              // Navigate to the '✡' page
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Online orders'),
            onTap: () {
              // Navigate to the online orders page
            },
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Codes'),
            onTap: () {
              // Navigate to the codes page
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigate to the settings page
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Navigate to the about page
            },
          ),
        ],
      ),
    );
  }
}