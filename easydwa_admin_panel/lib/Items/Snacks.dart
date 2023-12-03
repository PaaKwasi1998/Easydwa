import 'package:flutter/material.dart';

class SnacksPage extends StatefulWidget {
  @override
  State<SnacksPage> createState() => _SnacksPageState();
}

class _SnacksPageState extends State<SnacksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snacks Products'),
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
          Expanded(child: _buildSnacksGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewSnacks,
        child: Icon(Icons.add),
        tooltip: 'Add New Snacks Product',
      ),
    );
  }

  void _addNewSnacks() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Snacks Product'),
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

  Widget _buildSnacksGrid(BuildContext context) {
    return GridView.builder(
      itemCount: SnacksItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return SnacksItemCard(index: index);
      },
    );
  }
}

class SnacksItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Snacks/Belvita.jpg',
    'assets/Snacks/Chocolate digestive.jpg',
    'assets/Snacks/Dark cherry.jpg',
    'assets/Snacks/Digestives.jpg',
    'assets/Snacks/Golden oreo.jpg',
    'assets/Snacks/Gyori.jpg',
    'assets/Snacks/Kitkat.jpg',
    'assets/Snacks/M&M.jpg',
    'assets/Snacks/Mars.jpg',
    'assets/Snacks/Milka oreo.jpg',
    'assets/Snacks/Milka.jpg',
    'assets/Snacks/Oreo biscuit.jpg',
    'assets/Snacks/Potazos.jpg',
    'assets/Snacks/Premium popcorn.jpg',
    'assets/Snacks/Pringles.jpg',
    'assets/Snacks/Roshen cherry queen.jpg',
    'assets/Snacks/Skittles.jpg',
    'assets/Snacks/Snickers.jpg',
    'assets/Snacks/Tic tac.jpg',
    'assets/Snacks/Plantain chips.jpg',
    'assets/Snacks/Twix.jpg',
    'assets/Snacks/Wafer vanilla.jpg',
  ];

  static final List<double> prices = [
    12,15,18,12,8,11,5,4,8,15,
    15,8,6,20,13,22,9,7,5,20,8,14,
  ];

  SnacksItemCard({required this.index});

  @override
  State<SnacksItemCard> createState() => _SnacksItemCardState();
}

class _SnacksItemCardState extends State<SnacksItemCard> {
  final List<String> Snacks = [
    'Belvita',
    'Chocolate digestive',
    'Dark cherry',
    'Digestives',
    'Golden oreo',
    'Gyori',
    'Kitkat',
    'M&M',
    'Mars',
    'Milka oreo',
    'Milka',
    'Oreo biscuit',
    'Potazos',
    'Premium popcorn',
    'Pringles',
    'Roshen cherry queen',
    'Skittles',
    'Snickers',
    'Tic tac',
    'Plantain chips',
    'Twix',
    'Wafer vanilla',
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
              SnacksItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Snacks[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${SnacksItemCard.prices[widget.index].toString()}'),
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
                SnacksItemCard.imagePaths.removeAt(index);
                SnacksItemCard.prices.removeAt(index);
                Snacks.removeAt(index);
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
