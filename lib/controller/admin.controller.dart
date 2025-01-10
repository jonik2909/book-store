// lib/controller/author.controller.dart

import 'dart:io';
import 'package:book_store/models/Book.dart';
import 'package:book_store/services/BookService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final NewBookService bookService = NewBookService();
  static const int MAX_IMAGES = 3;

  // Observable states
  final RxBool isLoading = false.obs;
  final RxList<File> selectedImages = <File>[].obs;

  final RxList<NewBook> adminBooks = <NewBook>[].obs;

  @override
  void onReady() async {
    super.onReady();
    getAllBooks();
  }

  Future<void> getAllBooks() async {
    try {
      print("request getAllBooks");
      final books = await bookService.getAllBooks();

      adminBooks.assignAll(books);
    } catch (err) {
      Get.snackbar(
        'Error',
        err.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> removeBook(String bookId) async {
    try {
      await bookService.removeBook(bookId);

      getAllBooks();
    } catch (err) {
      Get.snackbar(
        'Error',
        err.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
