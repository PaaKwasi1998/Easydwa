import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BakeryItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Bakery/Apple pie.jpg',
    'assets/Bakery/Brown bread.jpg',
    'assets/Bakery/Butter croissant.jpg',
    'assets/Bakery/Coco bread.jpg',
    'assets/Bakery/Cocoa cookie.jpg',
    'assets/Bakery/Crunchy bread.jpg',
    'assets/Bakery/Cupcake.jpg',
    'assets/Bakery/Fresh bread.jpg',
    'assets/Bakery/Grano arso bread.jpg',
    'assets/Bakery/Neapolitan chocolate.jpg',
    'assets/Bakery/Pie.jpg',
    'assets/Bakery/Pita.jpg',
    'assets/Bakery/Puff loaf.jpg',
    'assets/Bakery/Raisin buns.jpg',
    'assets/Bakery/Sugar bread.jpg',
    'assets/Bakery/White bread.jpg',
    'assets/Bakery/Whole grain bread.jpg',
    'assets/Bakery/Wraps.jpg',

    //... continue for each fruit
  ];

  static final List<double> prices = [
    22,50,22,40,20,50,30,35,40,25,
    38,20,20,20,50,50,50,25,
  ];

  BakeryItemCard({required this.index});

  @override
  State<BakeryItemCard> createState() => _BakeryItemCardState();
}

class _BakeryItemCardState extends State<BakeryItemCard> {
  final List<String> bakery = [
    'Apple pie',
    'Brown bread',
    'Butter croissant',
    'Coco bread',
    'Cocoa cookie',
    'Crunchy bread',
    'Cupcake',
    'Fresh bread',
    'Grano arso bread',
    'Neapolitan chocolate',
    'Pie',
    'Pita',
    'Puff loaf',
    'Raisin buns',
    'Sugar bread',
    'White bread',
    'Whole grain bread',
    'Wraps',
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BakeryDetailPage(
              bakeryName: bakery[widget.index],
              imagePath: BakeryItemCard.imagePaths[widget.index],
              price: BakeryItemCard.prices[widget.index],
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
                image: AssetImage(BakeryItemCard.imagePaths[widget.index]),
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
                    '${bakery[widget.index]} - ₵${BakeryItemCard.prices[widget.index].toStringAsFixed(2)}',
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
                    name: bakery[widget.index],
                    price: BakeryItemCard.prices[widget.index],
                    imagePath: BakeryItemCard.imagePaths[widget.index],
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

class BakerysPage extends StatefulWidget {

  @override
  State<BakerysPage> createState() => _BakerysPageState();
}

class _BakerysPageState extends State<BakerysPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bakery"),
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
        itemCount: 18,
        itemBuilder: (BuildContext context, int index) {
          return BakeryItemCard(index: index);
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

class BakeryDetailPage extends StatelessWidget {
  final String bakeryName;
  final String imagePath;
  final double price; // Fixed price for an individual item

  BakeryDetailPage({
    required this.bakeryName,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        // Check if the item exists in the cart
        int quantity = 0;
        if (cart.itemsInCart.keys.any((item) => item.name == bakeryName)) {
          quantity = cart.itemsInCart.keys
              .where((item) => item.name == bakeryName)
              .map((item) => cart.itemsInCart[item]!)
              .first;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(bakeryName),
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
                bakeryName,
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
                      "Some detailed information about $bakeryName.", // Modify this text with actual details.
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
                                name: bakeryName,
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
                          name: bakeryName, price: price, imagePath: imagePath);
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
                      Item(name: bakeryName, price: price, imagePath: imagePath);
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
