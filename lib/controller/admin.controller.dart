import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminController extends GetxController {
  var bookName = ''.obs;
  var bookPrice = 0.0.obs;
  var bookDesc = ''.obs;
  var bookImage = ''.obs;
  var bookCategory = ''.obs;
  var bookAuthor = ''.obs;
  var bookAuthorDesc = ''.obs;

  final ImagePicker _picker = ImagePicker();

  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      bookImage.value = image.path;
    }
  }
}
