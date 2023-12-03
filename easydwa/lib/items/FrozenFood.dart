import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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



    //... continue for each fruit
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
  final List<String> frozens = [
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FrozenDetailPage(
              frozensName: frozens[widget.index],
              imagePath: FrozenItemCard.imagePaths[widget.index],
              price: FrozenItemCard.prices[widget.index],
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
                image: AssetImage(FrozenItemCard.imagePaths[widget.index]),
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
                    '${frozens[widget.index]} - ₵${FrozenItemCard.prices[widget.index].toStringAsFixed(2)}',
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
                      name: frozens[widget.index],
                      price: FrozenItemCard.prices[widget.index],
                      imagePath: FrozenItemCard.imagePaths[widget.index]);
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

class FrozenPage extends StatefulWidget {
  @override
  State<FrozenPage> createState() => _FrozenPageState();
}

class _FrozenPageState extends State<FrozenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frozen foods"),
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
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return FrozenItemCard(index: index);
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

class FrozenDetailPage extends StatelessWidget {
  final String frozensName;
  final String imagePath;
  final double price; // Fixed price for an individual item

  FrozenDetailPage({
    required this.frozensName,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        // Check if the vegetable exists in the cart
        int quantity = 0;
        if (cart.itemsInCart.keys.any((item) => item.name == frozensName)) {
          quantity = cart.itemsInCart.keys
              .where((item) => item.name == frozensName)
              .map((item) => cart.itemsInCart[item]!)
              .first;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(frozensName),
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
                frozensName,
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
                      "Some detailed information about $frozensName.", // Modify this text with actual details.
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
                                name: frozensName,
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
                          name: frozensName, price: price, imagePath: imagePath);
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
                      Item(name: frozensName, price: price, imagePath: imagePath);
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
