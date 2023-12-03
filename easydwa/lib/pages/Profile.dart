import 'package:easydwa/Controllers/Profilecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true; // for password visibility

  File? _imageFile; // to store the captured or selected image

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });

       final profileController = Get.put(ProfileController());
       profileController.updateProfileImage(_imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _imageFile == null
                      ? AssetImage('assets/profile.jpg') as ImageProvider<Object>
                      : FileImage(_imageFile!) as ImageProvider<Object>,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: _pickImage,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text("Full Name"),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Paa Kwasi'),
              ),
              SizedBox(height: 20),
              Text("Email"),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: 'example@example.com'),
              ),
              SizedBox(height: 20),
              Text("Phone Number"),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(hintText: '+1234567890'),
              ),
              SizedBox(height: 20),
              Text("Password"),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: '********',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save profile changes
                },
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}