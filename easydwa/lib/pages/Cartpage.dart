import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Paymentpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.itemsInCart.isEmpty
                ? Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.itemsInCart.keys.length,
                    itemBuilder: (context, index) {
                      Item cartItem = cart.itemsInCart.keys.elementAt(index);
                      int count = cart.itemsInCart[cartItem]!;

                      return ListTile(
                        leading: Image.asset(
                          cartItem.imagePath,
                          width: 70,
                          height: 70,
                        ),
                        title: Text(
                          cartItem.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("₵${(cartItem.price * count).toStringAsFixed(2)}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                cart.removeItem(cartItem);
                              },
                            ),
                            Text("$count"),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                cart.addItem(cartItem);
                              },
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                while (cart.itemsInCart.containsKey(cartItem)) {
                                  cart.removeItem(cartItem);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text("Checkout", style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                Get.to(PaymentPage());
              },
            ),
          )
        ],
      ),
    );
  }
}