import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CannedItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Canned Foods/African queen.jpg',
    'assets/Canned Foods/Beef stew.jpg',
    'assets/Canned Foods/Chicken noodle.jpg',
    'assets/Canned Foods/Corned beef.jpg',
    'assets/Canned Foods/Family.jpg',
    'assets/Canned Foods/Shito.jpg',
    'assets/Canned Foods/Tasty tom.jpg',
    'assets/Canned Foods/Titus.jpg',
    'assets/Canned Foods/Tuna flakes.jpg',
    'assets/Canned Foods/Vienna sausage.jpg',


  ];

  static final List<double> prices = [
    22,25,28,20,30,35,35,35,30,55,
  ];

  CannedItemCard({required this.index});

  @override
  State<CannedItemCard> createState() => _CannedItemCardState();
}

class _CannedItemCardState extends State<CannedItemCard> {
  final List<String> canned = [
    'African queen',
    'Beef stew',
    'Chicken noodle',
    'Corned beef',
    'Family',
    'Shito',
    'Tasty tom',
    'Titus',
    'Tuna flakes',
    'Vienna sausage',

  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CannedDetailPage(
              dairyName: canned[widget.index],
              imagePath: CannedItemCard.imagePaths[widget.index],
              price: CannedItemCard.prices[widget.index],
            ),
          ),
        );
      },
      child: Stack(
        children: [
          // Background image and name plate
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(CannedItemCard.imagePaths[widget.index]),
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
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: const Color.fromARGB(255, 4, 85, 7).withOpacity(0.7),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '${canned[widget.index]} - ₵${CannedItemCard.prices[widget.index].toStringAsFixed(2)}',
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
          // Add to cart button
          Positioned(
            top: 5,
            right: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.7),
              child: IconButton(
                onPressed: () {
                  var newItem = Item(
                    name: canned[widget.index],
                    price: CannedItemCard.prices[widget.index],
                    imagePath: CannedItemCard.imagePaths[widget.index],
                  );
                  Provider.of<CartModel>(context, listen: false)
                      .addItem(newItem);
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

class CannedPage extends StatefulWidget {

  @override
  State<CannedPage> createState() => _CannedPageState();
}

class _CannedPageState extends State<CannedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Canned Foods"),
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
          return CannedItemCard(index: index);
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

class CannedDetailPage extends StatelessWidget {
  final String dairyName;
  final String imagePath;
  final double price; // Fixed price for an individual item

  CannedDetailPage({
    required this.dairyName,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        // Check if the item exists in the cart
        int quantity = 0;
        if (cart.itemsInCart.keys.any((item) => item.name == dairyName)) {
          quantity = cart.itemsInCart.keys
              .where((item) => item.name == dairyName)
              .map((item) => cart.itemsInCart[item]!)
              .first;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(dairyName),
            backgroundColor: Colors.green,
          ),
          body: Column(
            children: [
              // Display the fruit image
              Container(
                height: 250, // Adjust this value as required
                width: double.infinity,
                child: Image.asset(imagePath, fit: BoxFit.fitWidth),
              ),
              SizedBox(height: 50),
              Text(
                dairyName,
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
                      "Some detailed information about $dairyName.", // Modify this text with actual details.
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
                                name: dairyName,
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
                          name: dairyName, price: price, imagePath: imagePath);
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
                      Item(name: dairyName, price: price, imagePath: imagePath);
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
