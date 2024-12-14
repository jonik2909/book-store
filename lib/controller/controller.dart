import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Controller extends GetxController {
  // category

  // current screen
  var currentScreen = 0.obs;
  void changeScreen(int index) {
    print("index: $index");
    print("currentScreen.value : ${currentScreen.value} ");
    currentScreen.value = index;
  }

  // image upload
  Rx<File?> _thumnailImage = Rx<File?>(null);
  Rx<File?> get thumnailImage => _thumnailImage;

  /// 썸네일 에러문
  Rx<String> thumnailError = ''.obs;

  Future picImage() async {
    try {
      var img = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (img == null) return;

      _thumnailImage.value = File(img.path);
      print(_thumnailImage.value);
    } on PlatformException catch (e) {
      print('[ERROR] pickImage error : $e');
    }
  }
}
