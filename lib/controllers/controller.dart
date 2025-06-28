import 'package:get/get.dart';

class Controller extends GetxController {
  // category

  // current screen
  var currentScreen = 0.obs;
  void changeScreen(int index) {
    currentScreen.value = index;
  }

  void resetScreen() {
    currentScreen.value = 0;
  }
}
