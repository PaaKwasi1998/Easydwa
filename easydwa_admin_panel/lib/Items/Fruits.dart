import 'package:flutter/material.dart';

class FruitPage extends StatefulWidget {
  @override
  State<FruitPage> createState() => _FruitPageState();
}

class _FruitPageState extends State<FruitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit Products'),
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
          Expanded(child: _buildFruitGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewFruit,
        child: Icon(Icons.add),
        tooltip: 'Add New Bakery Product',
      ),
    );
  }

  void _addNewFruit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Fruit Product'),
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

  Widget _buildFruitGrid(BuildContext context) {
    return GridView.builder(
      itemCount: FruitItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return FruitItemCard(index: index);
      },
    );
  }
}

class FruitItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/fruits/Apples.jpg',
    'assets/fruits/Banana.jpg',
    'assets/fruits/Avocado.jpg',
    'assets/fruits/Coconut.jpg',
    'assets/fruits/Kiwi.jpg',
    'assets/fruits/Lemon.jpg',
    'assets/fruits/Grapes.jpg',
    'assets/fruits/Mango.jpg',
    'assets/fruits/Blue berry.jpg',
    'assets/fruits/Red apples.jpg',
    'assets/fruits/Strawberry.jpg',
    'assets/fruits/Lime.jpg',
    'assets/fruits/Pineapple.jpg',
    'assets/fruits/Pomegranate.jpg',
    'assets/fruits/Orange.jpg',
    'assets/fruits/Pawpaw.jpg',
    'assets/fruits/Tangerine.jpg',
    'assets/fruits/Watermelon.jpg',
  ];

  static final List<double> prices = [
    10,8,12,10,20,7,25,15,30,
    10,25,8,15,20,7,13,10,25,
  ];

  FruitItemCard({required this.index});

  @override
  State<FruitItemCard> createState() => _FruitItemCardState();
}

class _FruitItemCardState extends State<FruitItemCard> {
  final List<String> Fruit = [
    'Apples','Banana','Avocado','Coconut','Kiwi','Lemon',
    'Grapes','Mango','Blue berry','Red apples','Strawberry',
    'Lime','Pineapple','Pomegranate','Orange','Pawpaw',
    'Tangerine','Watermelon',
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
              FruitItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Fruit[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${FruitItemCard.prices[widget.index].toString()}'),
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
                FruitItemCard.imagePaths.removeAt(index);
                FruitItemCard.prices.removeAt(index);
                Fruit.removeAt(index);
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
