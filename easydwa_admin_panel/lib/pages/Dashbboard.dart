import 'dart:io';

import 'package:easydwa_admin_panel/pages/Inbox.dart';
import 'package:easydwa_admin_panel/pages/LoginPage.dart';
import 'package:easydwa_admin_panel/pages/Productpage.dart';
import 'package:easydwa_admin_panel/pages/Sidebar.dart';
import 'package:easydwa_admin_panel/pages/curvedchart.dart';
import 'package:easydwa_admin_panel/pages/global.dart';
import 'package:easydwa_admin_panel/pages/piechart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

    @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context)
        .categories; // Get the categories using Provider
    final categoryCount = categories.length;





    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
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
                              LoginPage())); // Replace with your ProfilePage
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
          SizedBox(width: 10),
        ],
      ),
      drawer: SideBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _infoCard("Total Orders", "4,982", Icons.shopping_cart,
                    Colors.orange),
                _infoCard(
                    "Total Customers", "12,094", Icons.people, Colors.red),
                _infoCard('Totoal Categories', categoryCount.toString(),
                    Icons.category, Colors.blue),
                //... you can add more cards as required.
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      child: Container(
                        width: 660, // You can adjust this to your desired width
                        height: 500, // You can adjust this to your desired height
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: 80,),
                                _2infoCard("New Orders", "94", Icons.shopping_basket, Colors.green),
                                Spacer(),
                                _2infoCard("Delivered", "874", Icons.check, Colors.green),
                                SizedBox(width: 80,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: 80,),
                                _2infoCard("Out for Delivery", "261", Icons.local_shipping, Colors.yellow),
                                Spacer(),
                                _2infoCard("Cancelled", "25", Icons.cancel, Colors.red),
                                SizedBox(width: 80,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: PieChartSample2()
                ),
              ],
            ),
            SizedBox(height: 40,),
            
            Text("Orders Monthly",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            LineChartSample2(),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        elevation: 5, // subtle shadow
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, color.withOpacity(0.1)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: color, size: 32),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _2infoCard(String title, String count, IconData icon, Color color) {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => _controller.forward(),
          onExit: (_) => _controller.reverse(),
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 1.1).animate(_controller),
            child: Icon(icon, color: color, size: 80.0),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
        ),
        Text(
          count,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }


}
