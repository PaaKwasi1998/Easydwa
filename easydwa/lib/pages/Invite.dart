import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class InviteFriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Friends"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40.0),
            Text(
              'Invite Your Friends',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Invite your friends to try out our grocery delivery app. When your friend makes their first purchase, both of you will receive a discount!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 40.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () => _shareInvite(context),
                child: Text('Share Invite Link'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _shareInvite(BuildContext context) {
    final String appLink = "https://yourappdownloadlink.com";
    final String message =
        "Hey! I'm using this amazing grocery delivery app. Use my invite link to sign up and we both get a discount on our next purchase! $appLink";

    Share.share(message);
  }
}