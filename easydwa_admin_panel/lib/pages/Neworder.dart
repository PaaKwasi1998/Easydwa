import 'dart:io';

import 'package:easydwa_admin_panel/pages/Inbox.dart';
import 'package:easydwa_admin_panel/pages/LoginPage.dart';
import 'package:easydwa_admin_panel/pages/Sidebar.dart';
import 'package:easydwa_admin_panel/pages/global.dart';
import 'package:flutter/material.dart';

class NewOrderPage extends StatefulWidget {
  @override
  _NewOrderPageState createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _orderIdController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List<Order> orders = [
    Order(id: '123', customerName: 'John Doe', total: '\$150.00', date: '01/01/2023'),
    // Add more sample orders here
  ];

    void _showAddOrderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Order'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _orderIdController,
                  decoration: InputDecoration(labelText: 'Order ID'),
                  validator: (value) => value!.isEmpty ? 'Order ID is required' : null,
                ),
                TextFormField(
                  controller: _customerNameController,
                  decoration: InputDecoration(labelText: 'Customer Name'),
                  validator: (value) => value!.isEmpty ? 'Customer name is required' : null,
                ),
                TextFormField(
                  controller: _totalController,
                  decoration: InputDecoration(labelText: 'Total'),
                  validator: (value) => value!.isEmpty ? 'Total is required' : null,
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                  validator: (value) => value!.isEmpty ? 'Date is required' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    orders.add(
                      Order(
                        id: _orderIdController.text,
                        customerName: _customerNameController.text,
                        total: _totalController.text,
                        date: _dateController.text,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Orders'),
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
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5.0,
              child: ListTile(
                title: Text('Order #${orders[index].id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer: ${orders[index].customerName}'),
                    Text('Total: ${orders[index].total}'),
                    Text('Date: ${orders[index].date}'),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Implement the order detail view here
                  },
                  child: Text('View'),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOrderDialog,
        child: Icon(Icons.add),
        tooltip: 'Add New Order',
      ),
    );
  }
}

class Order {
  final String id;
  final String customerName;
  final String total;
  final String date;

  Order({required this.id, required this.customerName, required this.total, required this.date});
}