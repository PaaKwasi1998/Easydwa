import 'dart:io';

import 'package:easydwa_admin_panel/pages/Inbox.dart';
import 'package:easydwa_admin_panel/pages/LoginPage.dart';
import 'package:easydwa_admin_panel/pages/Sidebar.dart';
import 'package:easydwa_admin_panel/pages/global.dart';
import 'package:flutter/material.dart';

class OrdersReceivedPage extends StatefulWidget {
  @override
  _OrdersReceivedPageState createState() => _OrdersReceivedPageState();
}

class _OrdersReceivedPageState extends State<OrdersReceivedPage> {
  // Sample data for orders
  final List<Order> orders = [
    Order(id: '001', customerName: 'John', totalPrice: 250.0),
    Order(id: '002', customerName: 'Marry', totalPrice: 150.0),
    //... you can add more sample orders
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders Received'),
        backgroundColor: Colors.green,
        actions: [
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())); 
                      break;
                    case 'Inbox':
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InboxPage())); 
                      break;
                    case 'Logout':
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())); 
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
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text('Order ID: ${orders[index].id}'),
            subtitle: Text('Customer: ${orders[index].customerName}'),
            trailing: Text('\$${orders[index].totalPrice.toStringAsFixed(2)}'),
            onTap: () {
              // Action when an order is tapped, 
            },
          );
        },
      ),
    );
  }
}

class Order {
  final String id;
  final String customerName;
  final double totalPrice;

  Order({required this.id, required this.customerName, required this.totalPrice});
}