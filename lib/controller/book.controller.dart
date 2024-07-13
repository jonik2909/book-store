import 'dart:convert';

import 'package:book_store/models/Book.dart';
import 'package:book_store/services/BookService.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookController extends GetxController {
  var bookList = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getBooks();
  }

  Future<void> getBooks() async {
    try {
      isLoading(true);
      var books = await Bookservice.getBooks();
      if (books != null) {
        bookList.value = books;
      }
      print("books $books");
    } catch (err) {
      print("getBooks $err");
    } finally {
      isLoading(false);
    }
  }
}
