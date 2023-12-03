import 'package:easydwa/screens/HomeScreen.dart';
import 'package:easydwa/screens/TappingGame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ThankYouPage extends StatefulWidget {
  @override
  _ThankYouPageState createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _secondController;
  late final AnimationController _thirdController;
  late final AnimationController _fourthController;
  bool _firstAnimationCompleted = false;
  bool _secondAnimationCompleted = false;
  int _clickCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _secondController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _thirdController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _fourthController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _controller.forward().then((value) {
      setState(() {
        _firstAnimationCompleted = true;
      });
      _secondController.forward().then((value) {
        setState(() {
          _secondAnimationCompleted = true;
        });
        _thirdController.repeat();
        _fourthController.repeat(); // This is a separate line. It'll start the fourth animation in parallel with the third one.
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'circlePopUp',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_secondAnimationCompleted) // The fourth animation will only display when the second animation is completed.
                InkWell(
                  onTap: () {
                    Get.to(HomePage());
                  },
                  child: Lottie.asset(
                    'assets/animations/42174-home(1).json',
                    controller: _fourthController,
                    height: 30,
                    width: 30,
                    fit: BoxFit.fill,
                  ),
                ),
              Stack(
                children: [
                  if (!_firstAnimationCompleted)
                    Lottie.asset(
                      'assets/animations/972-done.json',
                      controller: _controller,
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                  if (_firstAnimationCompleted && !_secondAnimationCompleted)
                    Lottie.asset(
                      'assets/animations/113209-grocery-shopping-bag-pickup-and-delivery.json',
                      controller: _secondController,
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                  if (_secondAnimationCompleted)
                    GestureDetector(
                      onTap: () {
                        _clickCount++;
                        if (_clickCount >= 2) {
                          Get.to(TappingGame());
                        }
                      },
                      child: Lottie.asset(
                        'assets/animations/99271-food-out-for-delivery.json',
                        controller: _thirdController,
                        height: 300,
                        width: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Thank You!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();

    super.dispose();
  }
}