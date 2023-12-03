import 'package:flutter/material.dart';

class DessertsPage extends StatefulWidget {
  @override
  State<DessertsPage> createState() => _DessertsPageState();
}

class _DessertsPageState extends State<DessertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dessert Products'),
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
          Expanded(child: _buildDessertsGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDesserts,
        child: Icon(Icons.add),
        tooltip: 'Add New Dessert Product',
      ),
    );
  }

  void _addNewDesserts() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Dessert Product'),
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

  Widget _buildDessertsGrid(BuildContext context) {
    return GridView.builder(
      itemCount: DessertsItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return DessertsItemCard(index: index);
      },
    );
  }
}

class DessertsItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Desserts/Battenberg cake.jpg',
    'assets/Desserts/Cake with whipped cream.jpg',
    'assets/Desserts/Chocolate cake.jpg',
    'assets/Desserts/Chocolate ice cream cake.jpg',
    'assets/Desserts/Creme brulee.jpg',
    'assets/Desserts/Dessert with berries cream.jpg',
    'assets/Desserts/French silk pie.jpg',
    'assets/Desserts/Oreo cake.jpg',
    'assets/Desserts/Strawberry cake.jpg',
    'assets/Desserts/Strawberry cupcake.jpg',
    'assets/Desserts/Tiramisu.jpg',
    'assets/Desserts/Vanilla ice cream.jpg',
  ];

  static final List<double> prices = [
    52,
    45,
    50,
    30,
    32,
    34,
    57,
    60,
    40,
    25,
    48,
    8,
  ];

  DessertsItemCard({required this.index});

  @override
  State<DessertsItemCard> createState() => _DessertsItemCardState();
}

class _DessertsItemCardState extends State<DessertsItemCard> {
  final List<String> Dessert = [
    'Battenberg cake',
    'Cake with whipped cream',
    'Chocolate cake',
    'Chocolate ice cream cake',
    'Creme brulee',
    'Dessert with berries cream',
    'French silk pie',
    'Oreo cake',
    'Strawberry cake',
    'Strawberry cupcake',
    'Tiramisu',
    'Vanilla ice cream',
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
              DessertsItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Dessert[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${DessertsItemCard.prices[widget.index].toString()}'),
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
                DessertsItemCard.imagePaths.removeAt(index);
                DessertsItemCard.prices.removeAt(index);
                Dessert.removeAt(index);
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
