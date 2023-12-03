import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    //... continue for each fruit
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
  final List<String> snacks = [
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SnacksDetailPage(
              snacksName: snacks[widget.index],
              imagePath: SnacksItemCard.imagePaths[widget.index],
              price: SnacksItemCard.prices[widget.index],
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
                image: AssetImage(SnacksItemCard.imagePaths[widget.index]),
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
                    '${snacks[widget.index]} - ₵${SnacksItemCard.prices[widget.index].toStringAsFixed(2)}',
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
                    name: snacks[widget.index],
                    price: SnacksItemCard.prices[widget.index],
                    imagePath: SnacksItemCard.imagePaths[widget.index],
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

class SnacksPage extends StatefulWidget {

  @override
  State<SnacksPage> createState() => _SnacksPageState();
}

class _SnacksPageState extends State<SnacksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Snacks"),
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
        itemCount: 22,
        itemBuilder: (BuildContext context, int index) {
          return SnacksItemCard(index: index);
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

class SnacksDetailPage extends StatelessWidget {
  final String snacksName;
  final String imagePath;
  final double price; // Fixed price for an individual item

  SnacksDetailPage({
    required this.snacksName,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        // Check if the item exists in the cart
        int quantity = 0;
        if (cart.itemsInCart.keys.any((item) => item.name == snacksName)) {
          quantity = cart.itemsInCart.keys
              .where((item) => item.name == snacksName)
              .map((item) => cart.itemsInCart[item]!)
              .first;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(snacksName),
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
                snacksName,
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
                      "Some detailed information about $snacksName.", // Modify this text with actual details.
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
                                name: snacksName,
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
                          name: snacksName, price: price, imagePath: imagePath);
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
                      Item(name: snacksName, price: price, imagePath: imagePath);
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
