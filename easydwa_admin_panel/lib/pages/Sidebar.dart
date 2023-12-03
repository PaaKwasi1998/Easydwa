import 'package:easydwa_admin_panel/pages/Grocery.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
            DrawerHeader(
              child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDeliveryPanel())); // Navigate to GroceryPage when clicked
                              },
                child: Image.asset(
                  'assets/dwa.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255), // You can set the color to match your theme
              ),
            ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/Dashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Products"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/productsPage');
            },
          ),
          ListTile(
            leading: Icon(Icons.delivery_dining),
            title: Text("Deliveries"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/deliveryPage');
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Customers"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/customerpage');
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text("Invoices"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/invoicePage');
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text("New Order"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/newOrderPage');
            },
          ),
          ListTile(
            leading: Icon(Icons.playlist_add_check),
            title: Text("Received Orders"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/orderReceivedPage');
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
