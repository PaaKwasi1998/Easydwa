import 'package:easydwa_admin_panel/pages/Grocery.dart';
import 'package:easydwa_admin_panel/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

String globalEmail = "";
String globalPassword = "";

class SignupPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side with logo
            Expanded(
              child: Center(
                child: Image.asset('assets/dwa.jpg', fit: BoxFit.cover),
              ),
            ),
            // Right side with login fields
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Sign Up Account',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email ID',
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                            value: true,
                            onChanged: (value) {}), // Example checkbox
                        Text('Keep me signed in'),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Get.to(() => LoginPage());
                          },
                          child: Text('Login in'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                            try {
                              // Sign up using Firebase Authentication
                              final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                              if (userCredential.user != null) {
                                // Optionally, save the email and UID (or other info) in your app
                                globalEmail = userCredential.user!.email!;
                                // Navigate to your desired page, 
                                Get.to(() => GroceryDeliveryPanel());
                              }
                            } catch (e) {
                              if (e is FirebaseException) {
                                Get.snackbar("Error", e.message!); 
                              } else {
                                Get.snackbar("Error", e.toString());
                              }
                            }
                          },
                      child: Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
}
