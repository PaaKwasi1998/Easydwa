import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeveragesItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Beverages/7Up Citrus flavour.jpg',
    'assets/Beverages/Cappy orange.jpg',
    'assets/Beverages/Ceres apple.jpg',
    'assets/Beverages/Ceres juice blend.jpg',
    'assets/Beverages/Ceres mango.jpg',
    'assets/Beverages/Ceres white grapes.jpg',
    'assets/Beverages/Coca cola Cherry.jpg',
    'assets/Beverages/Coca cola Soft drink.jpg',
    'assets/Beverages/Coca cola zero lemon.jpg',
    'assets/Beverages/Coca cola zero.jpg',
    'assets/Beverages/Coca cola.jpg',
    'assets/Beverages/Fanta elder flavored.jpg',
    'assets/Beverages/Fanta Orange.jpg',
    'assets/Beverages/Ginger ale.jpg',
    'assets/Beverages/Pepsi Cola.jpg',
    'assets/Beverages/Pepsi Max.jpg',
    'assets/Beverages/Raunch happy day apple.jpg',
    'assets/Beverages/Raunch Happy Day Orange.jpg',
    'assets/Beverages/Raunch happy day pineapple.jpg',
    'assets/Beverages/Raunch happy day pomegranate.jpg',
    'assets/Beverages/Sio apple.jpg',
    'assets/Beverages/Sprite.jpg',

    //... continue for each fruit
  ];

  static final List<double> prices = [
    22,15,28,28,28,28,25,25,22,22,
    22,25,25,30,22,22,30,30,30,30,26,22,
  ];

  BeveragesItemCard({required this.index});

  @override
  State<BeveragesItemCard> createState() => _BeveragesItemCardState();
}

class _BeveragesItemCardState extends State<BeveragesItemCard> {
  final List<String> beverages = [
    '7Up Citrus flavour',
    'Cappy orange',
    'Ceres apple',
    'Ceres juice blend',
    'Ceres mango',
    'Ceres white grapes',
    'Coca cola Cherry',
    'Coca cola Soft drink',
    'Coca cola zero lemon',
    'Coca cola zero',
    'Coca cola',
    'Fanta elder flavored',
    'Fanta Orange',
    'Ginger ale',
    'Pepsi Cola',
    'Pepsi Max',
    'Raunch happy day apple',
    'Raunch Happy Day Orange',
    'Raunch happy day pineapple',
    'Raunch happy day pomegranate',
    'Sio apple',
    'Sprite',
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BeveragesDetailPage(
              beveragesName: beverages[widget.index],
              imagePath: BeveragesItemCard.imagePaths[widget.index],
              price: BeveragesItemCard.prices[widget.index],
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
                image: AssetImage(BeveragesItemCard.imagePaths[widget.index]),
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
                    '${beverages[widget.index]} - ₵${BeveragesItemCard.prices[widget.index].toStringAsFixed(2)}',
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
                    name: beverages[widget.index],
                    price: BeveragesItemCard.prices[widget.index],
                    imagePath: BeveragesItemCard.imagePaths[widget.index],
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

class BeveragesPage extends StatefulWidget {

  @override
  State<BeveragesPage> createState() => _BeveragesPageState();
}

class _BeveragesPageState extends State<BeveragesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beverages"),
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
          return BeveragesItemCard(index: index);
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

class BeveragesDetailPage extends StatelessWidget {
  final String beveragesName;
  final String imagePath;
  final double price; // Fixed price for an individual item

  BeveragesDetailPage({
    required this.beveragesName,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        // Check if the item exists in the cart
        int quantity = 0;
        if (cart.itemsInCart.keys.any((item) => item.name == beveragesName)) {
          quantity = cart.itemsInCart.keys
              .where((item) => item.name == beveragesName)
              .map((item) => cart.itemsInCart[item]!)
              .first;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(beveragesName),
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
                beveragesName,
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
                      "Some detailed information about $beveragesName.", // Modify this text with actual details.
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
                                name: beveragesName,
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
                          name: beveragesName, price: price, imagePath: imagePath);
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
                      Item(name: beveragesName, price: price, imagePath: imagePath);
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
