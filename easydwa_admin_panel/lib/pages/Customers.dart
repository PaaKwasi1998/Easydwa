import 'dart:io';

import 'package:easydwa_admin_panel/pages/Inbox.dart';
import 'package:easydwa_admin_panel/pages/LoginPage.dart';
import 'package:easydwa_admin_panel/pages/Sidebar.dart';
import 'package:easydwa_admin_panel/pages/global.dart';
import 'package:flutter/material.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final List<Map<String, String>> customers = [
    {
      'name': 'John Doe',
      'address': '123 Main St, City',
      'phone': '+1234567890'
    },
    //... other customer data
  ];

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Customer'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) => value!.isEmpty ? 'Name is required' : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Street Address'),
                  validator: (value) => value!.isEmpty ? 'Address is required' : null,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) => value!.isEmpty ? 'Phone number is required' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => value!.isEmpty ? 'Email is required' : null,
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
                    customers.add({
                      'name': _nameController.text,
                      'address': _addressController.text,
                      'phone': _phoneController.text,
                    });
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
        title: Text('Customers'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
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
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: customers.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                title: Text(customers[index]['name']!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(customers[index]['address']!),
                    Text(customers[index]['phone']!),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    // Handle navigation to detailed customer view
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddCustomerDialog,
      ),
    );
  }
}