import 'package:flutter/material.dart';

class CerealPage extends StatefulWidget {
  @override
  State<CerealPage> createState() => _CerealPageState();
}

class _CerealPageState extends State<CerealPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cereal Products'),
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
          Expanded(child: _buildCerealGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCereal,
        child: Icon(Icons.add),
        tooltip: 'Add New Cereal Product',
      ),
    );
  }

  void _addNewCereal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Cereal Product'),
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

  Widget _buildCerealGrid(BuildContext context) {
    return GridView.builder(
      itemCount: CerealItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return CerealItemCard(index: index);
      },
    );
  }
}

class CerealItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Cereals/Apple jacks.jpg',
    'assets/Cereals/Cheerios.jpg',
    'assets/Cereals/Coco pops.jpg',
    'assets/Cereals/Cocoa Krispies.jpg',
    'assets/Cereals/Cookie crisp.jpg',
    'assets/Cereals/Corn flakes.jpg',
    'assets/Cereals/Frosted flakes.jpg',
    'assets/Cereals/Oreo.jpg',
    'assets/Cereals/Rice krispies.jpg',
    'assets/Cereals/Trix.jpg',
  ];

  static final List<double> prices = [
    32,
    35,
    38,
    32,
    32,
    40,
    42,
    45,
    35,
    35,
  ];

  CerealItemCard({required this.index});

  @override
  State<CerealItemCard> createState() => _CerealItemCardState();
}

class _CerealItemCardState extends State<CerealItemCard> {
  final List<String> Cereal = [
    'Apple jacks',
    'Cheerios',
    'Coco pops',
    'Cocoa Krispies',
    'Cookie crisp',
    'Corn flakes',
    'Frosted flakes',
    'Oreo',
    'Rice krispies',
    'Trix',
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
              CerealItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              Cereal[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${CerealItemCard.prices[widget.index].toString()}'),
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
                CerealItemCard.imagePaths.removeAt(index);
                CerealItemCard.prices.removeAt(index);
                Cereal.removeAt(index);
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
