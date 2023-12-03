import 'dart:io';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var profileImage = 'assets/profile.jpg'.obs;

  void updateProfileImage(File? imageFile) {
    if (imageFile != null) {
      profileImage.value = imageFile.path;
    }
  }
}
