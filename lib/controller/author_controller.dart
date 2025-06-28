import 'dart:io';
import 'package:book_store/models/book.dart';
import 'package:book_store/services/book_service.dart';
import 'package:book_store/utils/image_picker_util.dart';
import 'package:book_store/utils/custom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorController extends GetxController {
  final BookService bookService = BookService();
  static const int MAX_IMAGES = 3;

  // Observable states
  final RxBool isLoading = false.obs;
  final RxList<File> selectedImages = <File>[].obs;

  final RxList<Book> authorBooks = <Book>[].obs;

  @override
  void onReady() async {
    super.onReady();
    getAuthorBooks();
  }

  Future<void> createBook(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;

      // Extract data from the map
      final String bookName = data['bookName'] ?? '';
      final int bookPrice = data['bookPrice'] ?? 0;
      final String bookDesc = data['bookDesc'] ?? '';
      final BookCategory bookCategory = data['bookCategory'];
      final List<File>? bookImages = data['bookImages'];

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

      Get.back();

      CustomBar.showSuccess('Book created successfully');
    } catch (err) {
      CustomBar.showError(err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAuthorBooks() async {
    try {
      print("request getAuthorBooks");
      final books = await bookService.getAuthorBooks();

      authorBooks.assignAll(books);
    } catch (err) {
      CustomBar.showError(err.toString());
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      await bookService.deleteBook(bookId);

      getAuthorBooks();
    } catch (err) {
      CustomBar.showError(err.toString());
    }
  }

  Future<void> updateBook({
    required String id,
    String? bookName,
    String? bookPrice,
    String? bookDesc,
    BookCategory? bookCategory,
    List<File>? bookImages,
  }) async {
    try {
      isLoading.value = true;

      await bookService.updateBook(
        id: id,
        bookName: bookName,
        bookPrice: bookPrice,
        bookDesc: bookDesc,
        bookCategory: bookCategory,
        bookImages: bookImages,
      );

      clearImages();

      Get.back();

      getAuthorBooks();

      CustomBar.showSuccess('Book updated successfully');
    } catch (err) {
      CustomBar.showError(err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickMultipleImages() async {
    if (selectedImages.length >= MAX_IMAGES) {
      CustomBar.showWarning('You can only upload 3 images',
          title: 'Limit Reached');

      return;
    }

    final List<File> pickedImages = await ImagePickerUtil.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      final remainingSlots = MAX_IMAGES - selectedImages.length;
      if (pickedImages.length > remainingSlots) {
        CustomBar.showWarning(
            'Only selecting first $remainingSlots images to meet the 3 image limit');

        selectedImages.addAll(pickedImages.take(remainingSlots));
      } else {
        selectedImages.addAll(pickedImages);
      }
    }
  }

  void clearImages() {
    selectedImages.clear();
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }
}
