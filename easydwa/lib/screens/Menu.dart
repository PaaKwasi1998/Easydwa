import 'dart:io';

import 'package:easydwa/Controllers/Profilecontroller.dart';
import 'package:easydwa/pages/Invite.dart';
import 'package:easydwa/pages/Orders.dart';
import 'package:easydwa/pages/PaymentMethod.dart';
import 'package:easydwa/pages/Profile.dart';
import 'package:easydwa/pages/Reorders.dart';
import 'package:easydwa/screens/LandingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  final bool isDarkMode;

  Menu({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color:
            isDarkMode ? const Color.fromARGB(255, 54, 54, 54) : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Stack for Profile Image and Menu Items
            Expanded(
              child: Stack(
                children: [
                  // User profile image section
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(() {
                        final profileController = Get.find<ProfileController>();
                        return CircleAvatar(
                          radius: 80.0,
                          backgroundColor: Colors.green,
                          backgroundImage: (profileController
                                      .profileImage.value ==
                                  'assets/profile.jpg')
                              ? AssetImage(profileController.profileImage.value)
                                  as ImageProvider<Object>
                              : FileImage(File(
                                      profileController.profileImage.value))
                                  as ImageProvider<Object>,
                        );
                      }),
                    ),
                  ),
                  // Menu Items wrapped in a SingleChildScrollView
                  Positioned.fill(
                    top: 170,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildTile(
                              icon: Icons.account_circle,
                              title: 'Profile',
                              onTap: () {
                                Get.to(ProfilePage());
                              }),
                          _buildTile(
                              icon: Icons.payment,
                              title: 'Payment Methods',
                              onTap: () {
                                Get.to(PaymentMethodPage());
                              }),
                          _buildTile(
                              icon: Icons.group_add,
                              title: 'Invite Friends',
                              onTap: () {
                                Get.to(InviteFriendsPage());
                              }),
                          _buildTile(
                              icon: Icons.list,
                              title: 'Orders',
                              onTap: () {
                                Get.to(OrdersPage());
                              }),
                          _buildTile(
                              icon: Icons.repeat,
                              title: 'Reordering',
                              onTap: () {
                                Get.to(ReorderPage());
                              }),
                          // ... rest of your drawer items ...
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Logout section
            ListTile(
              leading: Icon(
                Icons.logout,
                color: isDarkMode ? Color.fromARGB(255, 0, 0, 0) : Colors.green,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color:
                      isDarkMode ? Color.fromARGB(255, 0, 0, 0) : Colors.green,
                ),
              ),
              onTap: () {
                Get.to(landingPage());
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDarkMode ? Color.fromARGB(255, 0, 0, 0) : Colors.green,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDarkMode ? Color.fromARGB(255, 0, 0, 0) : Colors.green,
        ),
      ),
      onTap: onTap,
    );
  }
}
