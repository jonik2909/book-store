import 'package:book_store/models/NewBook.dart';
import 'package:book_store/services/NewBookService.dart';
import 'package:get/get.dart';

class NewBookController extends GetxController {
  final bookService = NewBookService();
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  final RxList<NewBook> topBooks = <NewBook>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> fetchBooks(
    String? order,
    int? page,
    int? limit,
    BookCategory? bookCategory,
    String? search,
  ) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await bookService.getBooks(
        order: order,
        page: page,
        limit: limit,
        bookCategory: bookCategory,
        search: search,
      );

      if (result['data'] is List) {
        topBooks.value = (result['data'] as List)
            .map((book) => NewBook.fromJson(book))
            .toList();
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print('Error fetching books: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
