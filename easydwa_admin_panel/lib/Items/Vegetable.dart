import 'package:flutter/material.dart';

class VegetablePage extends StatefulWidget {
  @override
  State<VegetablePage> createState() => _VegetablePageState();
}

class _VegetablePageState extends State<VegetablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetable Products'),
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
          Expanded(child: _buildVegetableGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewVegetable,
        child: Icon(Icons.add),
        tooltip: 'Add New Vegetable Product',
      ),
    );
  }

  void _addNewVegetable() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Vegetable Product'),
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

  Widget _buildVegetableGrid(BuildContext context) {
    return GridView.builder(
      itemCount: VegetableItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return VegetableItemCard(index: index);
      },
    );
  }
}

class VegetableItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/vegetables/Broccoli.jpg',
    'assets/vegetables/Cabbage.jpg',
    'assets/vegetables/Carrots.jpg',
    'assets/vegetables/Cauliflower.jpg',
    'assets/vegetables/Cucumber.jpg',
    'assets/vegetables/Eggplant.jpg',
    'assets/vegetables/Garden eggs.jpg',
    'assets/vegetables/Garlic.jpg',
    'assets/vegetables/Green pepper.jpg',
    'assets/vegetables/Lettuce.jpg',
    'assets/vegetables/Okro.jpg',
    'assets/vegetables/Onions.jpg',
    'assets/vegetables/Peas.jpg',
    'assets/vegetables/Pepper.jpg',
    'assets/vegetables/Potatoes.jpg',
    'assets/vegetables/Spinach.jpg',
    'assets/vegetables/Tomatoes.jpg',
    'assets/vegetables/Yam.jpg',
  ];

  static final List<double> prices = [
    60,25,22,40,10,10,12,5,10,
    20,8,12,13,15,25,30,15,25,
  ];

  VegetableItemCard({required this.index});

  @override
  State<VegetableItemCard> createState() => _VegetablesItemCardState();
}

class _VegetablesItemCardState extends State<VegetableItemCard> {
  final List<String> Vegetables = [
    'Broccoli','Cabbage','Carrots','Cauliflower','cucumber',
    'Eggplant','Garden eggs','Garlic','Green pepper',
    'Lettuce','Okro','Onions','Peas','Pepper',
    'Potatoes','Spinach','tomatoes','Yam',
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
              VegetableItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Vegetables[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${VegetableItemCard.prices[widget.index].toString()}'),
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
                VegetableItemCard.imagePaths.removeAt(index);
                VegetableItemCard.prices.removeAt(index);
                Vegetables.removeAt(index);
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
