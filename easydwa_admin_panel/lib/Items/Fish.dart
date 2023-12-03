import 'package:flutter/material.dart';

class FishPage extends StatefulWidget {
  @override
  State<FishPage> createState() => _FishPageState();
}

class _FishPageState extends State<FishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fish Products'),
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
          Expanded(child: _buildFishGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewFish,
        child: Icon(Icons.add),
        tooltip: 'Add New Fish Product',
      ),
    );
  }

  void _addNewFish() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Fish Product'),
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

  Widget _buildFishGrid(BuildContext context) {
    return GridView.builder(
      itemCount: FishItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return FishItemCard(index: index);
      },
    );
  }
}

class FishItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Fish/Catfish.jpg',
    'assets/Fish/Crayfish.jpg',
    'assets/Fish/Fresh fish mackerel.jpg',
    'assets/Fish/Lobster.jpg',
    'assets/Fish/Octopus.jpg',
    'assets/Fish/Oyster.jpg',
    'assets/Fish/Raw fresh fish.jpg',
    'assets/Fish/Raw salmon.jpg',
    'assets/Fish/Shrimp.jpg',
    'assets/Fish/Tilapia raw.jpg',
  ];

  static final List<double> prices = [
    120,
    200,
    38,
    250,
    132,
    80,
    57,
    80,
    40,
    65,
  ];

  FishItemCard({required this.index});

  @override
  State<FishItemCard> createState() => _FishItemCardState();
}

class _FishItemCardState extends State<FishItemCard> {
  final List<String> Fish = [
    'Catfish',
    'Crayfish',
    'Fresh fish mackerel',
    'Lobster',
    'Octopus',
    'Oyster',
    'Raw fresh fish',
    'Raw salmon',
    'Shrimp',
    'Tilapia raw',
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
              FishItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Fish[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${FishItemCard.prices[widget.index].toString()}'),
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
                FishItemCard.imagePaths.removeAt(index);
                FishItemCard.prices.removeAt(index);
                Fish.removeAt(index);
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
