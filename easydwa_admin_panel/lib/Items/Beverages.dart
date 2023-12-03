import 'package:flutter/material.dart';

class BeveragePage extends StatefulWidget {
  @override
  State<BeveragePage> createState() => _BeveragePageState();
}

class _BeveragePageState extends State<BeveragePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beverage Products'),
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
          Expanded(child: _buildBeverageGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBeverage,
        child: Icon(Icons.add),
        tooltip: 'Add New Beverage Product',
      ),
    );
  }

  void _addNewBeverage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Beverage Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Product Name'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Upload Image (Provide Path)'),
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

  Widget _buildBeverageGrid(BuildContext context) {
    return GridView.builder(
      itemCount: BeverageItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return BeverageItemCard(index: index);
      },
    );
  }
}

class BeverageItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
     'assets/Beverages/7Up Citrus flavour.jpg',
    'assets/Beverages/Cappy orange.jpg',
    'assets/Beverages/Ceres apple.jpg',
    'assets/Beverages/Ceres juice blend.jpg',
    'assets/Beverages/Ceres mango.jpg',
    'assets/Beverages/Ceres white grapes.jpg',
    'assets/Beverages/Coca cola Cherry.jpg',
    'assets/Beverages/Coca cola Soft drink.jpg',
    'assets/Beverages/Coca cola zero lemon.jpg',
    'assets/Beverages/Coca cola zero.jpg',
    'assets/Beverages/Coca cola.jpg',
    'assets/Beverages/Fanta elder flavored.jpg',
    'assets/Beverages/Fanta Orange.jpg',
    'assets/Beverages/Ginger ale.jpg',
    'assets/Beverages/Pepsi Cola.jpg',
    'assets/Beverages/Pepsi Max.jpg',
    'assets/Beverages/Raunch happy day apple.jpg',
    'assets/Beverages/Raunch Happy Day Orange.jpg',
    'assets/Beverages/Raunch happy day pineapple.jpg',
    'assets/Beverages/Raunch happy day pomegranate.jpg',
    'assets/Beverages/Sio apple.jpg',
    'assets/Beverages/Sprite.jpg',
  ];

  static final List<double> prices = [
 22,15,28,28,28,28,25,25,22,22,
    22,25,25,30,22,22,30,30,30,30,26,22,
  ];

  BeverageItemCard({required this.index});

  @override
  State<BeverageItemCard> createState() => _AlcoholItemCardState();
}

class _AlcoholItemCardState extends State<BeverageItemCard> {
  final List<String> Beverage = [
    '7Up Citrus flavour',
    'Cappy orange',
    'Ceres apple',
    'Ceres juice blend',
    'Ceres mango',
    'Ceres white grapes',
    'Coca cola Cherry',
    'Coca cola Soft drink',
    'Coca cola zero lemon',
    'Coca cola zero',
    'Coca cola',
    'Fanta elder flavored',
    'Fanta Orange',
    'Ginger ale',
    'Pepsi Cola',
    'Pepsi Max',
    'Raunch happy day apple',
    'Raunch Happy Day Orange',
    'Raunch happy day pineapple',
    'Raunch happy day pomegranate',
    'Sio apple',
    'Sprite',
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
              BeverageItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Beverage[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${BeverageItemCard.prices[widget.index].toString()}'),
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
                BeverageItemCard.imagePaths.removeAt(index);
                BeverageItemCard.prices.removeAt(index);
                Beverage.removeAt(index);
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