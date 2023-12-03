import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FishItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Fish/Catfish.jpg',
    'assets/Fish/Crayfish.jpg',
    'assets/Fish/Fresh fish mackerel.jpg',
    'assets/Fish/Lobster.jpg',
    'assets/Fish/Octopus.jpg',
    'assets/Fish/Oyster.jpg',
    'assets/Fish/Raw fresh fish.jpg',
    'assets/Fish/Raw salmon.jpg',
    'assets/Fish/Shrimp.jpg',
    'assets/Fish/Tilapia raw.jpg',


    //... continue for each fruit
  ];

  static final List<double> prices = [
    120,
    200,
    38,
    250,
    132,
    80,
    57,
    80,
    40,
    65,

  ];

  FishItemCard({required this.index});

  @override
  State<FishItemCard> createState() => _FishItemCardState();
}

class _FishItemCardState extends State<FishItemCard> {
  final List<String> fish = [
    'Catfish',
    'Crayfish',
    'Fresh fish mackerel',
    'Lobster',
    'Octopus',
    'Oyster',
    'Raw fresh fish',
    'Raw salmon',
    'Shrimp',
    'Tilapia raw',
    
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FishDetailPage(
              fishName: fish[widget.index],
              imagePath: FishItemCard.imagePaths[widget.index],
              price: FishItemCard.prices[widget.index],
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
                image: AssetImage(FishItemCard.imagePaths[widget.index]),
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
                    '${fish[widget.index]} - ₵${FishItemCard.prices[widget.index].toStringAsFixed(2)}',
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
                      name: fish[widget.index],
                      price: FishItemCard.prices[widget.index],
                      imagePath: FishItemCard.imagePaths[widget.index]);
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

class FishPage extends StatefulWidget {
  @override
  State<FishPage> createState() => _FishPageState();
}

class _FishPageState extends State<FishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fish"),
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
          return FishItemCard(index: index);
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

class FishDetailPage extends StatelessWidget {
  final String fishName;
  final String imagePath;
  final double price; // Fixed price for an individual item

  FishDetailPage({
    required this.fishName,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        // Check if the vegetable exists in the cart
        int quantity = 0;
        if (cart.itemsInCart.keys.any((item) => item.name == fishName)) {
          quantity = cart.itemsInCart.keys
              .where((item) => item.name == fishName)
              .map((item) => cart.itemsInCart[item]!)
              .first;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(fishName),
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
                fishName,
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
                      "Some detailed information about $fishName.", // Modify this text with actual details.
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
                                name: fishName,
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
                          name: fishName, price: price, imagePath: imagePath);
                      cart.addItem(newItem);
                    },
                  ),
                ],
              ),
              SizedBox(height: 50),

              // Add to cart button
              ElevatedButton(
                onPressed: () {
                  var newItem =
                      Item(name: fishName, price: price, imagePath: imagePath);
                  cart.setItemQuantity(newItem, quantity);
                  // Navigate to cart page or show a confirmation here if required
                },
                child: Text("Add to Cart",
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
