import 'package:flutter/material.dart';

class ReorderPage extends StatefulWidget {
  @override
  _ReorderPageState createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  final List<Order> _orders = [
    Order(orderNumber: '12345', date: '01/01/2023', totalAmount: '\$50.00'),
    Order(orderNumber: '12346', date: '02/01/2023', totalAmount: '\$30.00'),
    Order(orderNumber: '12347', date: '03/01/2023', totalAmount: '\$40.00'),
    // Add more orders as needed for mock data
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reorder Items"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text('Order #: ${_orders[index].orderNumber}'),
              subtitle: Text('Date: ${_orders[index].date}'),
              trailing: ElevatedButton(
                onPressed: () {
                  _reorderItems(_orders[index]);
                },
                child: Text('Reorder'),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ),
          );
        },
      ),
    );
  }

  _reorderItems(Order order) {
    // In a real-world scenario, this function would interact with your backend
    // to reorder the items from the provided order or add them to the user's cart.

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Items from Order #${order.orderNumber} have been reordered!'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

class Order {
  final String orderNumber;
  final String date;
  final String totalAmount;

  Order({required this.orderNumber, required this.date, required this.totalAmount});
}