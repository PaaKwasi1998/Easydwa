import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VegetableItemCard extends StatefulWidget {
  final int index;
  static final List<String> imagePaths = [
    'assets/vegetables/Broccoli.jpg',
    'assets/vegetables/Cabbage.jpg',
    'assets/vegetables/Carrots.jpg',
    'assets/vegetables/Cauliflower.jpg',
    'assets/vegetables/Cucumber.jpg',
    'assets/vegetables/Eggplant.jpg',
    'assets/vegetables/Garden eggs.jpg',
    'assets/vegetables/Garlic.jpg',
    'assets/vegetables/Green pepper.jpg',
    'assets/vegetables/Lettuce.jpg',
    'assets/vegetables/Okro.jpg',
    'assets/vegetables/Onions.jpg',
    'assets/vegetables/Peas.jpg',
    'assets/vegetables/Pepper.jpg',
    'assets/vegetables/Potatoes.jpg',
    'assets/vegetables/Spinach.jpg',
    'assets/vegetables/Tomatoes.jpg',
    'assets/vegetables/Yam.jpg',

    //... continue for each fruit
  ];

  static final List<double> prices = [
    60,25,22,40,10,10,12,5,10,
    20,8,12,13,15,25,30,15,25,
  ];

  VegetableItemCard({required this.index});

  @override
  State<VegetableItemCard> createState() => _VegetableItemCardState();
}

class _VegetableItemCardState extends State<VegetableItemCard> {
  final List<String> vegetables = [
    'Broccoli','Cabbage','Carrots','Cauliflower','cucumber',
    'Eggplant','Garden eggs','Garlic','Green pepper',
    'Lettuce','Okro','Onions','Peas','Pepper',
    'Potatoes','Spinach','tomatoes','Yam',
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VegetableDetailPage(
              vegetableName: vegetables[widget.index],
              imagePath: VegetableItemCard.imagePaths[widget.index],
              price: VegetableItemCard.prices[widget.index],
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
                image: AssetImage(VegetableItemCard.imagePaths[widget.index]),
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
                    '${vegetables[widget.index]} - ₵${VegetableItemCard.prices[widget.index].toStringAsFixed(2)}',
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
                      name: vegetables[widget.index],
                      price: VegetableItemCard.prices[widget.index],
                      imagePath: VegetableItemCard.imagePaths[widget.index]);
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

class VegetablesPage extends StatefulWidget {
  @override
  State<VegetablesPage> createState() => _VegetablesPageState();
}

class _VegetablesPageState extends State<VegetablesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vegetables"),
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
          return VegetableItemCard(index: index);
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

class VegetableDetailPage extends StatelessWidget {
  final String vegetableName;
  final String imagePath;
  final double price; // Fixed price for an individual item

  VegetableDetailPage({
    required this.vegetableName,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        // Check if the vegetable exists in the cart
        int quantity = 0;
        if (cart.itemsInCart.keys.any((item) => item.name == vegetableName)) {
          quantity = cart.itemsInCart.keys
              .where((item) => item.name == vegetableName)
              .map((item) => cart.itemsInCart[item]!)
              .first;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(vegetableName),
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
                vegetableName,
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
                      "Some detailed information about $vegetableName.", // Modify this text with actual details.
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
                                name: vegetableName,
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
                          name: vegetableName, price: price, imagePath: imagePath);
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
                      name: vegetableName, price: price, imagePath: imagePath);
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
