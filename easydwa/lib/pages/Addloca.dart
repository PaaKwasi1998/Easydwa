import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LocationController extends GetxController {
  var locations = <String>[].obs;
  var selectedLocation = ''.obs;

  void selectLocation(String location) {
    selectedLocation.value = location;
    update();
  }
}