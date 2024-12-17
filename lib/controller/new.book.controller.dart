import 'package:book_store/models/NewBook.dart';
import 'package:book_store/services/NewBookService.dart';
import 'package:get/get.dart';

class NewBookController extends GetxController {
  final bookService = NewBookService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // home page
  final RxList<NewBook> topBooks = <NewBook>[].obs;

  // chosenBook page
  final Rx<NewBook?> chosenBook = Rx<NewBook?>(null);

  @override
  void onInit() {
    super.onInit();
    refreshHomePageData();
  }

  Future<void> refreshHomePageData() async {
    errorMessage.value = '';

    await Future.wait([
      getBooks(
        targetList: topBooks,
        order: 'bookViews',
        page: 1,
        limit: 6,
      )
    ]);
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
    } catch (e) {
      errorMessage.value = e.toString();
      print('Controller error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getBook(String bookId) async {
    try {
      errorMessage.value = '';
      final response = await bookService.getBook(bookId);
      print(response);
      chosenBook.value = response;
    } catch (e) {
      errorMessage.value = e.toString();
      print('Controller error: $e');
    }
  }
}
