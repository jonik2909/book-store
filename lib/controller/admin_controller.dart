// lib/controller/author.controller.dart

import 'dart:io';
import 'package:book_store/models/book.dart';
import 'package:book_store/models/member.dart';
import 'package:book_store/services/book_service.dart';
import 'package:book_store/services/member_service.dart';
import 'package:book_store/utils/custom_bar.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final BookService bookService = BookService();
  final MemberService memberService = MemberService();

  // Observable states
  final RxBool isLoading = false.obs;
  final RxList<File> selectedImages = <File>[].obs;

  final RxList<Book> adminBooks = <Book>[].obs;
  final RxList<Member> adminMembers = <Member>[].obs;

  @override
  void onReady() async {
    super.onReady();
    getAllBooks();
    getAllMembers();
  }

  Future<void> getAllBooks() async {
    try {
      final books = await bookService.getAllBooks();

      adminBooks.assignAll(books);
    } catch (err) {
      CustomBar.showError(err.toString());
    }
  }

  Future<void> removeBook(String bookId) async {
    try {
      await bookService.removeBook(bookId);

      getAllBooks();
    } catch (err) {
      CustomBar.showError(err.toString());
    }
  }

  Future<void> getAllMembers() async {
    try {
      print("request getAllMembers");
      final members = await memberService.getAllBooks();

      adminMembers.assignAll(members);
    } catch (err) {
      CustomBar.showError(err.toString());
    }
  }

  Future<void> removeMember(String memberId) async {
    try {
      await memberService.removeMember(memberId);

      getAllMembers();
    } catch (err) {
      CustomBar.showError(err.toString());
    }
  }
}
