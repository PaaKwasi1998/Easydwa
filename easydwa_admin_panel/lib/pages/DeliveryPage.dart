import 'dart:io';

import 'package:easydwa_admin_panel/pages/Inbox.dart';
import 'package:easydwa_admin_panel/pages/LoginPage.dart';
import 'package:easydwa_admin_panel/pages/Sidebar.dart';
import 'package:easydwa_admin_panel/pages/global.dart';
import 'package:flutter/material.dart';

class DeliveriesPage extends StatefulWidget {
  @override
  State<DeliveriesPage> createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends State<DeliveriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Background color for better contrast
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Deliveries'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list),  // Added icon for clarity
            onSelected: (value) {
              // Handle filter action
            },
            itemBuilder: (BuildContext context) {
              return {'All', 'Pending', 'In Transit', 'Delivered'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())); // Replace with your ProfilePage
                      break;
                    case 'Inbox':
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InboxPage())); // Replace with your InboxPage
                      break;
                    case 'Logout':
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())); // Replace with your LoginPage
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
              SizedBox(width: 10),
        ],
      ),
      drawer:SideBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),  // Padding for better layout
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Card(  // Added Card for elevation effect
              elevation: 3.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),  // Vertical margin for spacing
              child: ListTile(
                contentPadding: EdgeInsets.all(12.0),  // Padding inside each ListTile
                title: Text('Order #12345', style: TextStyle(fontWeight: FontWeight.bold)),  // Made the order number bold
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,  // Aligning text to start
                  children: [
                    SizedBox(height: 4.0),  // Space between title and subtitle
                    Text('John Doe, 123 Street, City'),
                    SizedBox(height: 4.0),  // Space between customer data and status
                    Text('Expected: 20th Jan', style: TextStyle(color: Colors.blue)),
                    Text('Status: In Transit', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                  // Navigate to detailed delivery view
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,  // Button color
        child: Icon(Icons.add),
        onPressed: () {
          // Handle adding a new delivery
        },
      ),
    );
  }
  
}