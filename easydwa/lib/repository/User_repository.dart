import 'package:easydwa/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance; // For Firebase Authentication
  final FirebaseFirestore _db = FirebaseFirestore.instance; // For Firestore Database

  createUser(UserModel user) async {
    try {
      // Create a new Firebase Auth user (if you need authentication)
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email, 
        password: user.password // Ensure you have a password field in your UserModel
      );

      // Add user details to Firestore Database
      await _db.collection("Users").doc(userCredential.user!.uid).set(user.toJson());

      // Show success snackbar
      Get.snackbar(
        "Success", 
        "Your account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      // Handle errors
      Get.snackbar(
        "Error", 
        "Something went wrong.Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red
      );
      print(error.toString());
    }
  }
}