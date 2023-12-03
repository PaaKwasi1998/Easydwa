import 'dart:io';

import 'package:easydwa_admin_panel/pages/Inbox.dart';
import 'package:easydwa_admin_panel/pages/LoginPage.dart';
import 'package:easydwa_admin_panel/pages/Profile.dart';
import 'package:easydwa_admin_panel/pages/Sidebar.dart';
import 'package:easydwa_admin_panel/pages/global.dart';
import 'package:flutter/material.dart';

class GroceryDeliveryPanel extends StatefulWidget {
  @override
  _GroceryDeliveryPanelState createState() => _GroceryDeliveryPanelState();
}

class _GroceryDeliveryPanelState extends State<GroceryDeliveryPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // For drawer menu icon
            SizedBox(width: 10),
            Text(
              'Grocery Delivery Panel',
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        elevation: 1, // to provide a slight shadow
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.4, // Taking 40% of screen width for search bar
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search here',
                  labelStyle: TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(193, 172, 241, 193),
                  prefixIcon: Icon(Icons.search,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  isDense: true,
                ),
                onChanged: (value) {
                  // Handle search logic here
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications,
                color: const Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              // Handle notifications here
            },
          ),
          SizedBox(width: 10), // Spacing
          PopupMenuButton<String>(
            child: CircleAvatar(
              radius: 22.0,
              backgroundImage: selectedImagePath != null
                  ? FileImage(File(selectedImagePath!))
                  : AssetImage('assets/profile.jpg') as ImageProvider<Object>,
            ),
            onSelected: (String result) {
              switch (result) {
                case 'Profile':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfilePage())); // Replace with your ProfilePage
                  break;
                case 'Inbox':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InboxPage())); // Replace with your InboxPage
                  break;
                case 'Logout':
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginPage())); // Replace with your LoginPage
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Profile',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Inbox',
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text('Inbox'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Logout',
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
          SizedBox(width: 10), // Spacing
        ],
      ),
      drawer: SideBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Welcome Admin!',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Text(
                            'Manage your orders, view customer feedback, and keep track of inventory all in one place.',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  createGridItem(
                      'Orders', Icons.shopping_cart, '/orderReceivedPage'),
                  createGridItem('Inventory', Icons.inventory, '/productsPage'),
                  createGridItem('Feedback', Icons.feedback, '/feedback'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.green.shade200,
        child: Center(
            child: Text('Privacy Policy',
                style: TextStyle(fontWeight: FontWeight.bold))),
      ),
    );
  }

  Widget createGridItem(String title, IconData iconData, String routeName) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(routeName);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 48, color: Colors.green),
            SizedBox(height: 20),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
