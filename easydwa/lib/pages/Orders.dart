import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
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
        title: Text("Your Orders"),
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
              trailing: Text(_orders[index].totalAmount),
              onTap: () {
                // TODO: Navigate to detailed order page or show more details
                _showOrderDetails(context, _orders[index]);
              },
            ),
          );
        },
      ),
    );
  }

  _showOrderDetails(BuildContext context, Order order) {
    // This function is just for demonstration purposes.
    // In a real-world scenario, you'd navigate to a detailed order page or expand the order details.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order Details'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Order #: ${order.orderNumber}'),
            Text('Date: ${order.date}'),
            Text('Total: ${order.totalAmount}'),
            // Add more details as needed
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
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