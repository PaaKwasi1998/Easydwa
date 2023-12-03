import 'package:easydwa/screens/HomeScreen.dart';

import 'package:easydwa/screens/SignupScreen.dart';
import 'package:flutter/material.dart';

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  final _controller = PageController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  List<String> images = [
    'assets/log1.jpg',
    'assets/log2.jpg',
    'assets/log3.jpg',
    'assets/log4.jpg',
    'assets/log5.jpg',
    'assets/log6.jpg',
    'assets/log7.jpg',
    'assets/log8.jpg',
    'assets/log9.jpg',
    // Add paths to all your 9 images here
    // 'assets/image4.jpg',
    // ...
    // 'assets/image9.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), _changeImage);
  }

  void _changeImage() {
    if (_controller.page?.toInt() == images.length - 1) {
      _controller.animateToPage(
        0,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else {
      _controller.nextPage(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
    Future.delayed(Duration(seconds: 3), _changeImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landing Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.asset(images[index], fit: BoxFit.cover);
                },
              ),
            ),
            SizedBox(height: 20),
            TextField(
  controller: _emailController,
  decoration: InputDecoration(
    labelText: 'Email',
    prefixIcon: Icon(Icons.email),  // This is the email icon from Flutter's material icons
    // prefixIcon: Icon(Icons.person), // Uncomment this if you prefer the profile person icon
    border: OutlineInputBorder(),
  ),
),
            SizedBox(height: 10),
            
SizedBox(height: 10),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            child: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(),
        ),
        obscureText: !_isPasswordVisible, // Toggle the obscureText based on _isPasswordVisible
      ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to forgot password screen
              },
              child: Text('Forgot Password?'),
            ),
            
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));// Navigate or open login screen
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 18, 223, 70),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                       Text("Don't have an account?"),
                           TextButton(
                           onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                           // Navigate to the register screen or perform registration action
                           },
                        child: Text('Register', style: TextStyle(color: Colors.blue)),
                       )
                     ],
                    ),
          ],
        ),
      ),
    );
  }
}
