import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CerealsItemCard extends StatefulWidget {
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

    //... continue for each fruit
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

  CerealsItemCard({required this.index});

  @override
  State<CerealsItemCard> createState() => _CerealsItemCardState();
}

class _CerealsItemCardState extends State<CerealsItemCard> {
  final List<String> cereals = [
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CerealsDetailPage(
              cerealsName: cereals[widget.index],
              imagePath: CerealsItemCard.imagePaths[widget.index],
              price: CerealsItemCard.prices[widget.index],
            ),
          ),
        ); // Define any specific behavior for tapping on a fruit
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(15), // Increased border radius further
              image: DecorationImage(
                image: AssetImage(CerealsItemCard.imagePaths[widget.index]),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      // Adjusted for the bottom nameplate
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: const Color.fromARGB(255, 4, 85, 7).withOpacity(0.7),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '${cereals[widget.index]} - ₵${CerealsItemCard.prices[widget.index].toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.7),
              child: IconButton(
                onPressed: () {
                  var newItem = Item(
                      name: cereals[widget.index],
                      price: CerealsItemCard.prices[widget.index],
                      imagePath: CerealsItemCard.imagePaths[widget.index]);
                  Provider.of<CartModel>(context, listen: false)
                      .addItem(newItem);
                  // Define any specific behavior for the plus button tap
                },
                icon: Icon(Icons.add),
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CerealsPage extends StatefulWidget {
  @override
  State<CerealsPage> createState() => _CerealsPageState();
}

class _CerealsPageState extends State<CerealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cereals"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Define any specific behavior for the search button tap
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.05,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return CerealsItemCard(index: index);
        },
      ),
      floatingActionButton: Container(
        width: 90,
        height: 90,
        child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            child: Stack(
              children: <Widget>[
                Icon(Icons.shopping_cart, size: 60, color: Colors.white),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '${Provider.of<CartModel>(context).itemCount}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // bottom right position
    );
  }
}

class CerealsDetailPage extends StatelessWidget {
  final String cerealsName;
  final String imagePath;
  final double price; // Fixed price for an individual item

  CerealsDetailPage({
    required this.cerealsName,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        // Check if the vegetable exists in the cart
        int quantity = 0;
        if (cart.itemsInCart.keys.any((item) => item.name == cerealsName)) {
          quantity = cart.itemsInCart.keys
              .where((item) => item.name == cerealsName)
              .map((item) => cart.itemsInCart[item]!)
              .first;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(cerealsName),
            backgroundColor: Colors.green,
          ),
          body: Column(
            children: [
              // Display the vegetable image
              Container(
                height: 250, // Adjust this value as required
                width: double.infinity,
                child: Image.asset(imagePath, fit: BoxFit.fitWidth),
              ),
              SizedBox(height: 50),
              Text(
                cerealsName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),

              // Product Information section
              ExpansionTile(
                title: Text(
                  "Product Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Some detailed information about $cerealsName.", // Modify this text with actual details.
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Display total price for the selected quantity
              Text(
                '₵${(price * quantity).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 50),

              // Quantity adjuster
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Remove item button
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: (quantity > 1)
                        ? () {
                            var itemToRemove = Item(
                                name: cerealsName,
                                price: price,
                                imagePath: imagePath);
                            cart.removeItem(itemToRemove);
                          }
                        : null,
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(fontSize: 20),
                  ),
                  // Add item button
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      var newItem = Item(
                          name: cerealsName,
                          price: price,
                          imagePath: imagePath);
                      cart.addItem(newItem);
                    },
                  ),
                ],
              ),
              SizedBox(height: 50),

              // Add to cart button
              ElevatedButton(
                onPressed: () {
                  var newItem = Item(
                      name: cerealsName, price: price, imagePath: imagePath);
                  cart.setItemQuantity(newItem, quantity);
                  // Navigate to cart page or show a confirmation here if required
                },
                child:
                    Text("Add to Cart", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
