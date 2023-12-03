import 'package:flutter/material.dart';

class CannedPage extends StatefulWidget {
  @override
  State<CannedPage> createState() => _CannedPageState();
}

class _CannedPageState extends State<CannedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canned Food'),
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
          Expanded(child: _buildCannedGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCanned,
        child: Icon(Icons.add),
        tooltip: 'Add New Canned Food Product',
      ),
    );
  }

  void _addNewCanned() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Canned Food Product'),
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

  Widget _buildCannedGrid(BuildContext context) {
    return GridView.builder(
      itemCount: CannedItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return CannedItemCard(index: index);
      },
    );
  }
}

class CannedItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Canned Foods/African queen.jpg',
    'assets/Canned Foods/Beef stew.jpg',
    'assets/Canned Foods/Chicken noodle.jpg',
    'assets/Canned Foods/Corned beef.jpg',
    'assets/Canned Foods/Family.jpg',
    'assets/Canned Foods/Shito.jpg',
    'assets/Canned Foods/Tasty tom.jpg',
    'assets/Canned Foods/Titus.jpg',
    'assets/Canned Foods/Tuna flakes.jpg',
    'assets/Canned Foods/Vienna sausage.jpg',
  ];

  static final List<double> prices = [
     22,25,28,20,30,35,35,35,30,55,
  ];

  CannedItemCard({required this.index});

  @override
  State<CannedItemCard> createState() => _CannedItemCardState();
}

class _CannedItemCardState extends State<CannedItemCard> {
  final List<String> Canned = [
    'African queen',
    'Beef stew',
    'Chicken noodle',
    'Corned beef',
    'Family',
    'Shito',
    'Tasty tom',
    'Titus',
    'Tuna flakes',
    'Vienna sausage',
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
              CannedItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Canned[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${CannedItemCard.prices[widget.index].toString()}'),
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
                CannedItemCard.imagePaths.removeAt(index);
                CannedItemCard.prices.removeAt(index);
                Canned.removeAt(index);
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
