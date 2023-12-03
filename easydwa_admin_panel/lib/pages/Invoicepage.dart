import 'dart:io';

import 'package:easydwa_admin_panel/pages/Inbox.dart';
import 'package:easydwa_admin_panel/pages/LoginPage.dart';
import 'package:easydwa_admin_panel/pages/Sidebar.dart';
import 'package:easydwa_admin_panel/pages/global.dart';
import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              // Implement print functionality here
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
      drawer: SideBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invoice #12345', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer: John Doe'),
                    Text('Shipping Address: 123 Flutter St, Dart City, 56789'),
                  ],
                ),
                Text('Date: 01/01/2023'),
              ],
            ),
            Divider(),
            SizedBox(height: 20),
            Text('Payment Method: Credit Card', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // This should be the length of items
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    child: ListTile(
                      title: Text('Product Name ${index+1}'),
                      subtitle: Text('Description of the product ${index+1}'),
                      trailing: Text('\$100'), // Replace with the actual price
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$500', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tax (10%)', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$50', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('\$550', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}