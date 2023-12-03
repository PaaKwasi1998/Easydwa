import 'package:flutter/material.dart';

class DairyPage extends StatefulWidget {
  @override
  State<DairyPage> createState() => _DairyPageState();
}

class _DairyPageState extends State<DairyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dairy Products'),
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
          Expanded(child: _buildDairyGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDairy,
        child: Icon(Icons.add),
        tooltip: 'Add New Dairy Product',
      ),
    );
  }

  void _addNewDairy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Dairy Product'),
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

  Widget _buildDairyGrid(BuildContext context) {
    return GridView.builder(
      itemCount: DairyItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return DairyItemCard(index: index);
      },
    );
  }
}

class DairyItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Dairy&Eggs/Butter spread.jpg',
    'assets/Dairy&Eggs/Carte dor creme.jpg',
    'assets/Dairy&Eggs/Carte Dor.jpg',
    'assets/Dairy&Eggs/Chocolate ice cream.jpg',
    'assets/Dairy&Eggs/Chocolate milk.jpg',
    'assets/Dairy&Eggs/Creamy creations.jpg',
    'assets/Dairy&Eggs/Danone yoghurt toppings.jpg',
    'assets/Dairy&Eggs/Eggs.jpg',
    'assets/Dairy&Eggs/French vanilla.jpg',
    'assets/Dairy&Eggs/Greek yoghurt.jpg',
    'assets/Dairy&Eggs/Happy milk.jpg',
    'assets/Dairy&Eggs/Ideal milk.jpg',
    'assets/Dairy&Eggs/Jumbo eggs.jpg',
    'assets/Dairy&Eggs/Milli vanilla.jpg',
    'assets/Dairy&Eggs/Riso.jpg',
    'assets/Dairy&Eggs/Yogurt danone natural sugared.jpg',
    'assets/Dairy&Eggs/Yoplait strawberry.jpg',
    'assets/Dairy&Eggs/Zottis Desert.jpg',
  ];

  static final List<double> prices = [
    12,85,100,120,30,195,10,35,130,25,
    38,8,40,10,13,15,33,25,
  ];

  DairyItemCard({required this.index});

  @override
  State<DairyItemCard> createState() => _DairyItemCardState();
}

class _DairyItemCardState extends State<DairyItemCard> {
  final List<String> Dairy = [
    'Butter spread',
    'Carte dor creme',
    'Carte Dor',
    'Chocolate ice cream',
    'Chocolate milk',
    'Creamy creations',
    'Danone yoghurt toppings',
    'Eggs',
    'French vanilla',
    'Greek yoghurt',
    'Happy milk',
    'Ideal milk',
    'Jumbo eggs',
    'Milli vanilla',
    'Riso',
    'Yogurt danone natural sugared',
    'Yoplait strawberry',
    'Zottis Desert',
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
              DairyItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Dairy[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${DairyItemCard.prices[widget.index].toString()}'),
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
                DairyItemCard.imagePaths.removeAt(index);
                DairyItemCard.prices.removeAt(index);
                Dairy.removeAt(index);
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
