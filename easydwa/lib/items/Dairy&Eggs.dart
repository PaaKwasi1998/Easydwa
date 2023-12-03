import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DairyItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/Dairy&Eggs/Butter spread.jpg',
    'assets/Dairy&Eggs/Carte dor creme.jpg',
    'assets/Dairy&Eggs/Carte Dor.jpg',
    'assets/Dairy&Eggs/Chocolate ice cream.jpg',
    'assets/Dairy&Eggs/Chocolate milk.jpg',
    'assets/Dairy&Eggs/Creamy creations.jpg',
    'assets/Dairy&Eggs/Danone yoghurt toppings.jpg',
    'assets/Dairy&Eggs/Eggs.jpg',
    'assets/Dairy&Eggs/French vanilla.jpg',
    'assets/Dairy&Eggs/Greek yoghurt.jpg',
    'assets/Dairy&Eggs/Happy milk.jpg',
    'assets/Dairy&Eggs/Ideal milk.jpg',
    'assets/Dairy&Eggs/Jumbo eggs.jpg',
    'assets/Dairy&Eggs/Milli vanilla.jpg',
    'assets/Dairy&Eggs/Riso.jpg',
    'assets/Dairy&Eggs/Yogurt danone natural sugared.jpg',
    'assets/Dairy&Eggs/Yoplait strawberry.jpg',
    'assets/Dairy&Eggs/Zottis Desert.jpg',

    //... continue for each fruit
  ];

  static final List<double> prices = [
    12,85,100,120,30,195,10,35,130,25,
    38,8,40,10,13,15,33,25,
  ];

  DairyItemCard({required this.index});

  @override
  State<DairyItemCard> createState() => _DairyItemCardState();
}

class _DairyItemCardState extends State<DairyItemCard> {
  final List<String> dairy = [
    'Butter spread',
    'Carte dor creme',
    'Carte Dor',
    'Chocolate ice cream',
    'Chocolate milk',
    'Creamy creations',
    'Danone yoghurt toppings',
    'Eggs',
    'French vanilla',
    'Greek yoghurt',
    'Happy milk',
    'Ideal milk',
    'Jumbo eggs',
    'Milli vanilla',
    'Riso',
    'Yogurt danone natural sugared',
    'Yoplait strawberry',
    'Zottis Desert',
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DairyDetailPage(
              dairyName: dairy[widget.index],
              imagePath: DairyItemCard.imagePaths[widget.index],
              price: DairyItemCard.prices[widget.index],
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
                image: AssetImage(DairyItemCard.imagePaths[widget.index]),
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
                    '${dairy[widget.index]} - ₵${DairyItemCard.prices[widget.index].toStringAsFixed(2)}',
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
                    name: dairy[widget.index],
                    price: DairyItemCard.prices[widget.index],
                    imagePath: DairyItemCard.imagePaths[widget.index],
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

class DairysPage extends StatefulWidget {

  @override
  State<DairysPage> createState() => _DairysPageState();
}

class _DairysPageState extends State<DairysPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dairy & Eggs"),
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
          return DairyItemCard(index: index);
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

class DairyDetailPage extends StatelessWidget {
  final String dairyName;
  final String imagePath;
  final double price; // Fixed price for an individual item

  DairyDetailPage({
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
