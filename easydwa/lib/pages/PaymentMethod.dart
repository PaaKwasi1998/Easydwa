import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Payment Method"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            Text(
              'Choose a payment method:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ListTile(
              title: Text("Credit Card"),
              leading: Radio<String>(
                value: "Credit Card",
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Debit Card"),
              leading: Radio<String>(
                value: "Debit Card",
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("PayPal"),
              leading: Radio<String>(
                value: "PayPal",
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
             ListTile(
              title: Text("Mobile Money"),
              leading: Radio<String>(
                value: "Mobile Money",
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
             ListTile(
              title: Text("Cash"),
              leading: Radio<String>(
                value: "Cash",
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            // You can add more payment methods as needed
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: _selectedPaymentMethod == null
                  ? null
                  : () {
                      _proceedToPayment(context);
                    },
              child: Text('Proceed to Payment'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _proceedToPayment(BuildContext context) {
    // TODO: Handle actual payment processing here
    // For this example, just showing a message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Method Selected'),
        content: Text('You selected $_selectedPaymentMethod.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}