import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Add.dart';
import 'package:easydwa/pages/Addloca.dart';
import 'package:easydwa/pages/Location.dart';
import 'package:easydwa/pages/Thankyou.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart'; // Use flutter_map
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isLoading = false;

  void _onPaymentConfirmed() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a delay for payment processing
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    Get.to(ThankYouPage());
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  CardController cardController = Get.find();

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    const double SERVICE_FEE = 15.0;

    double totalPrice = 0;
    cart.itemsInCart.forEach((item, count) {
      totalPrice += item.price * count;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Flutter Map
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.2, // Adjust this height as needed
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/Easydwa.jpg'), // Replace with your own image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ExpansionTile(
                    title: Text(
                      'Delivery Address',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    leading:
                        Icon(Icons.location_on, color: Colors.green, size: 24),
                    children: [
                      GetBuilder<LocationController>(
                        builder: (controller) {
                          return Column(
                            children: controller.locations.map((location) {
                              return ListTile(
                                leading: Icon(Icons.place),
                                title: Text(location),
                                trailing: controller.selectedLocation.value ==
                                        location
                                    ? Icon(Icons.check, color: Colors.green)
                                    : null,
                                onTap: () {
                                  controller.selectLocation(location);
                                },
                              );
                            }).toList()
                              ..add(
                                ListTile(
                                  leading: Icon(Icons.add),
                                  title: Text('Add new address'),
                                  onTap: () {
                                    Get.to(LocationPage());
                                  },
                                ),
                              ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ExpansionTile(
                    title: Text(
                      'Payment Method',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(Icons.payment, color: Colors.green, size: 24),
                    children: [
                      GetBuilder<CardController>(
                        builder: (controller) {
                          return Column(
                            children: controller.cards.map((card) {
                              return ListTile(
                                leading: Icon(Icons.credit_card_outlined),
                                title: Text(
                                    'Card: **** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}'),
                                trailing: controller.selectedCard.value == card
                                    ? Icon(Icons.check, color: Colors.green)
                                    : null,
                                onTap: () {
                                  controller.selectCard(card);
                                },
                              );
                            }).toList()
                              ..add(
                                ListTile(
                                  leading: Icon(Icons.add),
                                  title: Text('Add new card'),
                                  onTap: () {
                                    Get.to(AddCard());
                                  },
                                ),
                              ),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton.icon(
                            onPressed: () => _selectTime(context),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green), // Theme color for button
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical:
                                          12)), // Padding for better sizing
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(fontSize: 18, color: Colors.white)),
                            ),
                            icon: Icon(Icons.access_time, color: Colors.white),
                            label: Text('Select Delivery Time'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.list,
                            color: Colors.green,
                            size:
                                24), // An icon representing the order summary. Adjust as needed.
                        SizedBox(
                            width:
                                10), // Some space between the icon and the text
                        Text(
                          "Order summary",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics:
                        NeverScrollableScrollPhysics(), // Prevent scrolling
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
                        subtitle: Text(
                            "₵${(cartItem.price * count).toStringAsFixed(2)} x $count"),
                      );
                    },
                  ),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "Service Fee: ₵${SERVICE_FEE.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "Total: ₵${(totalPrice + SERVICE_FEE).toStringAsFixed(2)}", // Add service fee to total
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          if (_isLoading) Center(child: CircularProgressIndicator()),
          if (!_isLoading)
            ConfirmationSlider(
              backgroundColor: Color.fromARGB(255, 163, 221, 165),
              foregroundColor: Colors.green,
              iconColor: Colors.white,
              height: 50,
              text: 'Slide to Pay',
              onConfirmation: _onPaymentConfirmed,
            ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class CardController extends GetxController {
  var cards = <CreditCardModel>[].obs;
  var selectedCard = Rx<CreditCardModel?>(null);

  void selectCard(CreditCardModel card) {
    selectedCard.value = card;
    update();
  }
}
