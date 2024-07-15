import 'package:book_store/services/AdminService.dart';
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

  var bookList = [].obs;
  var memberList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getAdminBooks();
    getAdminMembers();
  }

  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      bookImage.value = image.path;
    }
  }

  Future<void> getAdminBooks() async {
    try {
      var books = await AdminService.getAdminBooks();
      bookList.value = books;
    } catch (err) {
      print("getAdminBooks $err");
    }
  }

  Future<void> getAdminMembers() async {
    try {
      var members = await AdminService.getAdminMembers();
      memberList.value = members;
    } catch (err) {
      print("memberList $err");
    }
  }
}
