import 'package:flutter/material.dart';

class JamPage extends StatefulWidget {
  @override
  State<JamPage> createState() => _JamPageState();
}

class _JamPageState extends State<JamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jam Products'),
        backgroundColor: Colors.green,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'),
          )
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildJamGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewJam,
        child: Icon(Icons.add),
        tooltip: 'Add New Jam Product',
      ),
    );
  }

  void _addNewJam() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Jam Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Product Name'),
            ),
            TextField(
              decoration:
                  InputDecoration(hintText: 'Upload Image (Provide Path)'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Price'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Details'),
            ),
            ElevatedButton(
              onPressed: () {
                // Logic to add new product to list
              },
              child: Text('Done'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildJamGrid(BuildContext context) {
    return GridView.builder(
      itemCount: JamItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return JamItemCard(index: index);
      },
    );
  }
}

class JamItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Jam/Apple jam.jpg',
    'assets/Jam/Blueberry jam.jpg',
    'assets/Jam/Concord grape jam.jpg',
    'assets/Jam/Lemon jam.jpg',
    'assets/Jam/Nutella.jpg',
    'assets/Jam/Orange jam.jpg',
    'assets/Jam/Peanut butter.jpg',
    'assets/Jam/Raspberry jam.jpg',
    'assets/Jam/Strawberry and honey.jpg',
    'assets/Jam/Strawberry jam.jpg',
  ];

  static final List<double> prices = [
    12,
    15,
    18,
    11,
    32,
    19,
    37,
    20,
    20,
    15,
  ];

  JamItemCard({required this.index});

  @override
  State<JamItemCard> createState() => _JamItemCardState();
}

class _JamItemCardState extends State<JamItemCard> {
  final List<String> Jam = [
    'Apple jam',
    'Blueberry jam',
    'Concord grape jam',
    'Lemon jam',
    'Nutella',
    'Pepper spice',
    'Peanut butter',
    'Raspberry jam',
    'Strawberry and honey',
    'Strawberry jam',
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showDeleteConfirmation(context, widget.index);
      },
      child: Card(
        child: Column(
          children: [
            Image.asset(
              JamItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Jam[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${JamItemCard.prices[widget.index].toString()}'),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Item'),
        content: Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                JamItemCard.imagePaths.removeAt(index);
                JamItemCard.prices.removeAt(index);
                Jam.removeAt(index);
              });
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
