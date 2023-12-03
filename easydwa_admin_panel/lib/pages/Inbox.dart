import 'package:flutter/material.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  // Sample inbox data; in a real application, you'd fetch this from a backend
  List<Map<String, dynamic>> messages = [
    {'name': 'John', 'message': 'Query about delivery.'},
    {'name': 'Jane', 'message': 'Issue with the order.', 'isNew': true},
    {'name': 'Doe', 'message': 'Feedback on the new feature.'},
    // ... add more message entries
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inbox"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: CircleAvatar(
                backgroundColor: message['isNew'] == true ? Colors.green : Colors.grey[300],
                child: Icon(Icons.message, color: Colors.white),
              ),
              title: Text(
                message['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(message['message']),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onPressed: () {
                  // Navigate to detailed message view or perform another action
                },
              ),
              onTap: () {
                // Mark the message as read or navigate to detailed view
                setState(() {
                  if (message['isNew'] == true) {
                    message['isNew'] = false;
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}