import 'package:easydwa_admin_panel/pages/Dashbboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:easydwa_admin_panel/pages/Customers.dart';
import 'package:easydwa_admin_panel/pages/DeliveryPage.dart';
import 'package:easydwa_admin_panel/pages/Feedback.dart';
import 'package:easydwa_admin_panel/pages/Grocery.dart';
import 'package:easydwa_admin_panel/pages/Invoicepage.dart';
import 'package:easydwa_admin_panel/pages/LoginPage.dart';
import 'package:easydwa_admin_panel/pages/Neworder.dart';
import 'package:easydwa_admin_panel/pages/OrdersReceived.dart';
import 'package:easydwa_admin_panel/pages/Productpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAO9ow9xuPx6W7GOv0tHbNzBGoQfkYVkFs", // Replace with your actual API key
      authDomain: "easydwa-5a05d.firebaseapp.com",
      projectId: "easydwa-5a05d",
      storageBucket: "easydwa-5a05d.appspot.com",
      messagingSenderId: "500290421800",
      appId: "1:500290421800:web:6cc0ff39619780fd4fe11d",
      measurementId: "G-XJW3ZZNJX3"
    ),
  );
  runApp(
    ChangeNotifierProvider(
    create: (context) => CategoryProvider(),
    child: MyApp(),
  ));
}catch(error) {
    print('Firebase initialization failed: $error');
    // Optionally, run the app with limited functionality or show an error screen
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Delivery Panel',
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginPage(),
      initialRoute: '/',
      routes: {
        '/Grocery': (context) => GroceryDeliveryPanel(),
        '/Dashboard': (context) => DashboardPage(),
        '/productsPage': (context) => AdminProductPage(),
        '/deliveryPage': (context) => DeliveriesPage(),
        '/customerpage': (context) => CustomerPage(),
        '/invoicePage': (context) => InvoicePage(),
        '/newOrderPage': (context) => NewOrderPage(),
        '/orderReceivedPage': (context) => OrdersReceivedPage(),
        '/feedback': (context) => FeedbackPage(),
      },
    );
  }
}