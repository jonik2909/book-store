import 'dart:io';

import 'package:book_store/services/AdminService.dart';
import 'package:book_store/services/UploadService.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminController extends GetxController {
  var bookCategory = ''.obs;
  var bookImage = ''.obs;
  var imagePreview = ''.obs;

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
      File file = File(image!.path);
      final result = await UploadService.uploadImage(file);

      imagePreview.value = image.path;
      bookImage.value = result;
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

  Future<void> deleteMember(int id) async {
    try {
      await AdminService.deleteMember(id);
    } catch (err) {
      print("deleteMember >> $err");
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

  Future<void> createBook(data) async {
    try {
      await AdminService.createBook(data);
    } catch (err) {
      print("createBook >> $err");
    }
  }

  Future<void> deleteBook(String id) async {
    try {
      await AdminService.deleteBook(id);
    } catch (err) {
      print("createBook >> $err");
    }
  }
}
