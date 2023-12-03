import 'package:easydwa/pages/Paymentpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  // Initialize formKey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Add Card'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (CreditCardBrand) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: formKey, // Assign the initialized formKey
                      cardHolderName: cardHolderName,
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cvvCode: cvvCode,
                      onCreditCardModelChange: onCreditCardModelChange,
                      themeColor: Color.fromARGB(255, 29, 199, 106),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print('Credit Card is valid');
                            // Create CreditCardModel
                            CreditCardModel card = CreditCardModel(
                              cardNumber,
                              expiryDate,
                              cardHolderName,
                              cvvCode,
                              isCvvFocused,
                            );
                            // Get the CardController instance
                            CardController cardController = Get.find();
                            // Add the new card to the list
                            cardController.cards.add(card);
                            // Navigate back to DeliveryPage
                            Get.to(PaymentPage());
                          } else {
                            print('Credit Card is not valid');
                          }
                        },
                      child: Text('Finish'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}