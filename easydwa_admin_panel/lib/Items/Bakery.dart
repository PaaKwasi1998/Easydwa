import 'package:flutter/material.dart';

class BakerysPage extends StatefulWidget {
  @override
  State<BakerysPage> createState() => _BakerysPageState();
}

class _BakerysPageState extends State<BakerysPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bakery Products'),
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
          Expanded(child: _buildBakeryGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBakery,
        child: Icon(Icons.add),
        tooltip: 'Add New Bakery Product',
      ),
    );
  }

  void _addNewBakery() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Bakery Product'),
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

  Widget _buildBakeryGrid(BuildContext context) {
    return GridView.builder(
      itemCount: BakeryItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return BakeryItemCard(index: index);
      },
    );
  }
}

class BakeryItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Bakery/Apple pie.jpg',
    'assets/Bakery/Brown bread.jpg',
    'assets/Bakery/Butter croissant.jpg',
    'assets/Bakery/Coco bread.jpg',
    'assets/Bakery/Cocoa cookie.jpg',
    'assets/Bakery/Crunchy bread.jpg',
    'assets/Bakery/Cupcake.jpg',
    'assets/Bakery/Fresh bread.jpg',
    'assets/Bakery/Grano arso bread.jpg',
    'assets/Bakery/Neapolitan chocolate.jpg',
    'assets/Bakery/Pie.jpg',
    'assets/Bakery/Pita.jpg',
    'assets/Bakery/Puff loaf.jpg',
    'assets/Bakery/Raisin buns.jpg',
    'assets/Bakery/Sugar bread.jpg',
    'assets/Bakery/White bread.jpg',
    'assets/Bakery/Whole grain bread.jpg',
    'assets/Bakery/Wraps.jpg',
  ];

  static final List<double> prices = [
    22,
    50,
    22,
    40,
    20,
    50,
    30,
    35,
    40,
    25,
    38,
    20,
    20,
    20,
    50,
    50,
    50,
    25,
  ];

  BakeryItemCard({required this.index});

  @override
  State<BakeryItemCard> createState() => _BakeryItemCardState();
}

class _BakeryItemCardState extends State<BakeryItemCard> {
  final List<String> Bakery = [
    'Apple pie',
    'Brown bread',
    'Butter croissant',
    'Coco bread',
    'Cocoa cookie',
    'Crunchy bread',
    'Cupcake',
    'Fresh bread',
    'Grano arso bread',
    'Neapolitan chocolate',
    'Pie',
    'Pita',
    'Puff loaf',
    'Raisin buns',
    'Sugar bread',
    'White bread',
    'Whole grain bread',
    'Wraps',
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
              BakeryItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Bakery[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${BakeryItemCard.prices[widget.index].toString()}'),
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
                BakeryItemCard.imagePaths.removeAt(index);
                BakeryItemCard.prices.removeAt(index);
                Bakery.removeAt(index);
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
