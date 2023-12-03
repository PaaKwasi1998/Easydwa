import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  // Sample feedback data; in a real application, you'd fetch this from a backend
  List<Map<String, dynamic>> feedbacks = [
    {'name': 'John', 'feedback': 'Great service!'},
    {'name': 'Jane', 'feedback': 'The delivery was late.'},
    {'name': 'Doe', 'feedback': 'The app is easy to use.'},
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: feedbacks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(feedbacks[index]['name']),
            subtitle: Text(feedbacks[index]['feedback']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Implement deletion logic here, perhaps prompt admin for confirmation first
                setState(() {
                  feedbacks.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Implement add feedback logic here, this could navigate to another page where admin can manually add feedback entries
        },
      ),
    );
  }
}