import 'package:flutter/material.dart';

class AlcoholPage extends StatefulWidget {
  @override
  State<AlcoholPage> createState() => _AlcoholPageState();
}

class _AlcoholPageState extends State<AlcoholPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alcohol Products'),
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
          Expanded(child: _buildAlcoholGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAlcohol,
        child: Icon(Icons.add),
        tooltip: 'Add New Alcohol Product',
      ),
    );
  }

  void _addNewAlcohol() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Alcohol Product'),
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

  Widget _buildAlcoholGrid(BuildContext context) {
    return GridView.builder(
      itemCount: AlcoholItemCard.imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return AlcoholItemCard(index: index);
      },
    );
  }
}

class AlcoholItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Alcohol/Absolut Vodka 1l 40.jpg',
    'assets/Alcohol/Antinori Chianti Classico Riserva 2019.jpg',
    'assets/Alcohol/Ballantines.jpg',
    'assets/Alcohol/Guerrieri rizzardi prosecco grande.jpg',
    'assets/Alcohol/Jack daniels whiskey.jpg',
    'assets/Alcohol/Johnnie walker whiskey.jpg',
    'assets/Alcohol/Penfolds st henri shiraz 2017.jpg',
    'assets/Alcohol/Royal vodka 1000ml.jpg',
    'assets/Alcohol/Sierra Tequila Silver 38.jpg',
    'assets/Alcohol/Tanqueray london dry gin.jpg',
  ];

  static final List<double> prices = [
    212,
    210,
    168,
    220,
    420,
    400,
    237,
    235,
    200,
    215,
  ];

  AlcoholItemCard({required this.index});

  @override
  State<AlcoholItemCard> createState() => _AlcoholItemCardState();
}

class _AlcoholItemCardState extends State<AlcoholItemCard> {
  final List<String> alcohol = [
    'Absolut Vodka 1l 40',
    'Antinori Chianti Classico Riserva 2019',
    'Ballantines',
    'Guerrieri rizzardi prosecco grande',
    'Jack daniels whiskey',
    'Johnnie walker whiskey',
    'Penfolds st henri shiraz 2017',
    'Royal vodka 1000ml',
    'Sierra Tequila Silver 38',
    'Tanqueray london dry gin',
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
              AlcoholItemCard.imagePaths[widget.index],
              fit: BoxFit.contain,
              width: 360,
              height: 360,
            ),
            Text(
              alcohol[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${AlcoholItemCard.prices[widget.index].toString()}'),
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
                AlcoholItemCard.imagePaths.removeAt(index);
                AlcoholItemCard.prices.removeAt(index);
                alcohol.removeAt(index);
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