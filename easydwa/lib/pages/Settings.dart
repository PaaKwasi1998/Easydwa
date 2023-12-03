import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _receiveNotifications = true;
  bool _receiveOffersByEmail = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          // Language Option
          ListTile(
            title: Text('Language'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: <String>['English', 'Twi', 'German']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Text('Receive Notifications'),
            trailing: Switch(
              value: _receiveNotifications,
              onChanged: (value) {
                setState(() {
                  _receiveNotifications = value;
                  // TODO: Implement notification setting logic here
                });
              },
            ),
          ),
          ListTile(
            title: Text('Receive Offers by Email'),
            trailing: Switch(
              value: _receiveOffersByEmail,
              onChanged: (value) {
                setState(() {
                  _receiveOffersByEmail = value;
                  // TODO: Implement email offers setting logic here
                });
              },
            ),
          ),
          // You can continue to add more settings options as needed...
        ],
      ),
    );
  }
}
