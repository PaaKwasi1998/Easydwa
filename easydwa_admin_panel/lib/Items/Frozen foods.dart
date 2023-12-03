import 'package:flutter/material.dart';

class FrozenPage extends StatefulWidget {
  @override
  State<FrozenPage> createState() => _FrozenPageState();
}

class _FrozenPageState extends State<FrozenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frozen Products'),
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
          Expanded(child: _buildFrozenGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewFrozen,
        child: Icon(Icons.add),
        tooltip: 'Add New Frozen Product',
      ),
    );
  }

  void _addNewFrozen() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Frozen Product'),
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

  Widget _buildFrozenGrid(BuildContext context) {
    return GridView.builder(
      itemCount: FrozenItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return FrozenItemCard(index: index);
      },
    );
  }
}

class FrozenItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Frozen foods/Broccoli.jpg',
    'assets/Frozen foods/Digiorno.jpg',
    'assets/Frozen foods/Edge pizza.jpg',
    'assets/Frozen foods/Farmland mixed veggies.jpg',
    'assets/Frozen foods/Fish sticks.jpg',
    'assets/Frozen foods/Frozen burger.jpg',
    'assets/Frozen foods/Ristorante.jpg',
    'assets/Frozen foods/Supreme.jpg',
  ];

  static final List<double> prices = [
    95,
    160,
    165,
    110,
    48,
    55,
    200,
    185,
  ];

  FrozenItemCard({required this.index});

  @override
  State<FrozenItemCard> createState() => _FrozenItemCardState();
}

class _FrozenItemCardState extends State<FrozenItemCard> {
  final List<String> Frozen = [
    'Broccoli',
    'Digiorno',
    'Edge pizza',
    'Farmland mixed veggies',
    'Fish sticks',
    'Frozen burger',
    'Ristorante',
    'Supreme',
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
              FrozenItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Frozen[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${FrozenItemCard.prices[widget.index].toString()}'),
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
                FrozenItemCard.imagePaths.removeAt(index);
                FrozenItemCard.prices.removeAt(index);
                Frozen.removeAt(index);
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
