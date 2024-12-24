// lib/controller/author.controller.dart

import 'dart:io';
import 'package:book_store/models/NewBook.dart';
import 'package:book_store/services/NewBookService.dart';
import 'package:book_store/utils/image_picker_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorController extends GetxController {
  final NewBookService bookService = NewBookService();
  static const int MAX_IMAGES = 3;

  // Observable states
  final RxBool isLoading = false.obs;
  final RxList<File> selectedImages = <File>[].obs;

  Future<void> createBook(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;

      // Extract data from the map
      final String bookName = data['bookName'] ?? '';
      final int bookPrice = data['bookPrice'] ?? 0;
      final String bookDesc = data['bookDesc'] ?? '';
      final BookCategory bookCategory = data['bookCategory'];
      final List<File>? bookImages = data['bookImages'];

      // Validate required fields
      if (bookName.isEmpty || bookPrice <= 0 || bookDesc.isEmpty) {
        throw 'Please fill all required fields';
      }

      // Call the service method
      await bookService.createBook(
        bookName: bookName,
        bookPrice: bookPrice,
        bookDesc: bookDesc,
        bookCategory: bookCategory,
        bookImages: bookImages,
      );

      // Clear selected images
      selectedImages.clear();
    } catch (err) {
      throw err;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickMultipleImages() async {
    if (selectedImages.length >= MAX_IMAGES) {
      Get.snackbar(
        'Limit Reached',
        'You can only upload 3 images',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    final List<File> pickedImages = await ImagePickerUtil.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      final remainingSlots = MAX_IMAGES - selectedImages.length;
      if (pickedImages.length > remainingSlots) {
        Get.snackbar(
          'Warning',
          'Only selecting first $remainingSlots images to meet the 3 image limit',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        selectedImages.addAll(pickedImages.take(remainingSlots));
      } else {
        selectedImages.addAll(pickedImages);
      }
    }
  }

  void clearImages() {
    selectedImages.clear();
  }

  // Remove a specific image
  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }
}
