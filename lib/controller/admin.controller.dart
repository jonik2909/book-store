// lib/controller/author.controller.dart

import 'dart:io';
import 'package:book_store/models/Book.dart';
import 'package:book_store/models/Member.dart';
import 'package:book_store/services/BookService.dart';
import 'package:book_store/services/MemberService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final NewBookService bookService = NewBookService();
  final MemberService memberService = MemberService();

  // Observable states
  final RxBool isLoading = false.obs;
  final RxList<File> selectedImages = <File>[].obs;

  final RxList<NewBook> adminBooks = <NewBook>[].obs;
  final RxList<Member> adminMembers = <Member>[].obs;

  @override
  void onReady() async {
    super.onReady();
    getAllBooks();
    getAllMembers();
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

  Future<void> getAllMembers() async {
    try {
      print("request getAllMembers");
      final members = await memberService.getAllBooks();

      adminMembers.assignAll(members);
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

  Future<void> removeMember(String memberId) async {
    try {
      await memberService.removeMember(memberId);

      getAllMembers();
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
