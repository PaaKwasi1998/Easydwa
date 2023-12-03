import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 4000),
      () => Navigator.pushNamed(context, '/landing'),
    );

    return Scaffold(
      body: Center(
        child: Image.asset('assets/dwa.jpg'), // Your logo here
      ),
    );
  }
}

