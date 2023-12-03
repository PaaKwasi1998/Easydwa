import 'package:flutter/material.dart';

class MeatPage extends StatefulWidget {
  @override
  State<MeatPage> createState() => _MeatPageState();
}

class _MeatPageState extends State<MeatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meat Products'),
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
          Expanded(child: _buildMeatGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewMeat,
        child: Icon(Icons.add),
        tooltip: 'Add New Meat Product',
      ),
    );
  }

  void _addNewMeat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Meat Product'),
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

  Widget _buildMeatGrid(BuildContext context) {
    return GridView.builder(
      itemCount: MeatItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return MeatItemCard(index: index);
      },
    );
  }
}

class MeatItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/meats/Beef.jpg',
    'assets/meats/Bison.jpg',
    'assets/meats/Chicken breast.jpg',
    'assets/meats/Chicken thighs.jpg',
    'assets/meats/Duck.jpg',
    'assets/meats/Full chicken.jpg',
    'assets/meats/Goat.jpg',
    'assets/meats/Guinea fowl.jpg',
    'assets/meats/Pork.jpg',
    'assets/meats/Snail.jpg',
    'assets/meats/Turkey.jpg',
    'assets/meats/Veal.jpg',
  ];

  static final List<double> prices = [
    100,
    150,
    80,
    90,
    100,
    150,
    180,
    80,
    75,
    85,
    110,
    100,
  ];

  MeatItemCard({required this.index});

  @override
  State<MeatItemCard> createState() => _MeatItemCardState();
}

class _MeatItemCardState extends State<MeatItemCard> {
  final List<String> Meat = [
    'Beef',
    'Bison',
    'Chicken breast',
    'Chicken thighs',
    'Duck',
    'Full chicken',
    'Goat',
    'Guinea fowl',
    'Pork',
    'Snail',
    'Turkey',
    'Veal',
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
              MeatItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Meat[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${MeatItemCard.prices[widget.index].toString()}'),
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
                MeatItemCard.imagePaths.removeAt(index);
                MeatItemCard.prices.removeAt(index);
                Meat.removeAt(index);
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
