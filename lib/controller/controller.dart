import 'package:get/get.dart';

class Controller extends GetxController {
  // category
  var selectedCategory = 0.obs;

  void changeCategory(int index) {
    selectedCategory.value = index;
  }
}
