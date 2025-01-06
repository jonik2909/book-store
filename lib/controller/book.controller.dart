import 'package:book_store/models/Book.dart';
import 'package:book_store/services/BookService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewBookController extends GetxController {
  final bookService = NewBookService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Home Page
  final RxList<NewBook> topBooks = <NewBook>[].obs;

  // Books Page
  final RxList<NewBook> books = <NewBook>[].obs;
  final Rx<BookCategory> selectedCategory = BookCategory.FANTASY.obs;
  void changeCategory(BookCategory category) {
    selectedCategory.value = category;
  }

  // Chosen Book Page
  final Rx<NewBook?> chosenBook = Rx<NewBook?>(null);

  @override
  void onReady() async {
    super.onReady();
    refreshHomePageData();

    getBookPagedata(BookCategory.FANTASY);
  }

  Future<void> refreshHomePageData() async {
    errorMessage.value = '';

    getBooks(
      targetList: topBooks,
      order: 'bookViews',
      page: 1,
      limit: 6,
    );
  }

  Future<void> getBookPagedata(BookCategory category) async {
    errorMessage.value = '';

    getBooks(
      targetList: books,
      order: 'createdAt',
      bookCategory: category,
      page: 1,
      limit: 50,
    );
  }

  Future<void> getBooks({
    required RxList<NewBook> targetList,
    String? order,
    int? page,
    int? limit,
    BookCategory? bookCategory,
    String? search,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final books = await bookService.getBooks(
        order: order,
        page: page,
        limit: limit,
        bookCategory: bookCategory,
        search: search,
      );

      targetList.assignAll(books);
    } catch (err) {
      Get.snackbar(
        'Error',
        err.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getBook(String bookId) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await bookService.getBook(bookId);
      chosenBook.value = response;
    } catch (err) {
      Get.snackbar(
        'Error',
        err.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
