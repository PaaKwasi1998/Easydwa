import 'package:easydwa/Controllers/Profilecontroller.dart';
import 'package:easydwa/cartmodel/cartmodel.dart';
import 'package:easydwa/pages/Addloca.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:easydwa/pages/Paymentpage.dart';
import 'package:easydwa/screens/HomeScreen.dart';
import 'package:easydwa/screens/LandingScreen.dart';
import 'package:easydwa/screens/SignupScreen.dart';
import 'package:easydwa/screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  Get.put(ProfileController());
  Get.put(LocationController());
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final cardController = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: 'Grocery Delivery App',
            theme: ThemeData(
              primarySwatch: Colors.green,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.green,
              brightness: Brightness.dark,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              '/landing': (context) => landingPage(),
              '/SignUp': (context) => SignUpPage(),
              '/HomePage': (context) => HomePage(),
              '/CartPage': (context) => CartPage(),
              '/PaymentPage': (context) => PaymentPage(),
            },
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error initializing Firebase'));
        }

        return CircularProgressIndicator(); // Alternatively, show a loader until Firebase is initialized
      },
    );
  }
}
