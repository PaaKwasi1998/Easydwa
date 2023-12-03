import 'package:flutter/material.dart';

class OilPage extends StatefulWidget {
  @override
  State<OilPage> createState() => _OilPageState();
}

class _OilPageState extends State<OilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oil Products'),
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
          Expanded(child: _buildOilGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewOil,
        child: Icon(Icons.add),
        tooltip: 'Add New Oil Product',
      ),
    );
  }

  void _addNewOil() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Oil Product'),
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

  Widget _buildOilGrid(BuildContext context) {
    return GridView.builder(
      itemCount: OilItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return OilItemCard(index: index);
      },
    );
  }
}

class OilItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Oil&spices/Black pepper.jpg',
    'assets/Oil&spices/Cinnamon powder.jpg',
    'assets/Oil&spices/Garlic and pepper.jpg',
    'assets/Oil&spices/Nutmeg.jpg',
    'assets/Oil&spices/Oregano spice.jpg',
    'assets/Oil&spices/Pepper spice.jpg',
    'assets/Oil&spices/Salt.jpg',
    'assets/Oil&spices/Sweet basil.jpg',
    'assets/Oil&spices/Venus cooking oil.jpg',
    'assets/Oil&spices/Venus frying oil.jpg',
  ];

  static final List<double> prices = [
    12,
    15,
    20,
    11,
    20,
    17,
    20,
    25,
    40,
    41,
  ];

  OilItemCard({required this.index});

  @override
  State<OilItemCard> createState() => _OilItemCardState();
}

class _OilItemCardState extends State<OilItemCard> {
  final List<String> Oil = [
    'Black pepper',
    'Cinnamon powder',
    'Garlic and pepper',
    'Nutmeg',
    'Oregano spice',
    'Pepper spice',
    'Salt',
    'Sweet basil',
    'Venus cooking oil',
    'Venus frying oil',
    
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
              OilItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Oil[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${OilItemCard.prices[widget.index].toString()}'),
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
                OilItemCard.imagePaths.removeAt(index);
                OilItemCard.prices.removeAt(index);
                Oil.removeAt(index);
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
