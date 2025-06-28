import 'package:book_store/models/book.dart';
import 'package:book_store/services/book_service.dart';
import 'package:book_store/utils/custom_bar.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  final bookService = BookService();

  final RxBool isLoading = false.obs;

  // Home Page
  final RxList<Book> topBooks = <Book>[].obs;

  // Books Page
  final RxList<Book> books = <Book>[].obs;
  final Rx<BookCategory> selectedCategory = BookCategory.FANTASY.obs;
  void changeCategory(BookCategory category) {
    selectedCategory.value = category;
  }

  // Chosen Book Page
  final Rx<Book?> chosenBook = Rx<Book?>(null);

  @override
  void onReady() async {
    super.onReady();

    refreshHomePageData();
    getBookPagedata(BookCategory.FANTASY);
  }

  Future<void> refreshHomePageData() async {
    getBooks(
      targetList: topBooks,
      order: 'bookViews',
      page: 1,
      limit: 6,
    );
  }

  Future<void> getBookPagedata(BookCategory category) async {
    getBooks(
      targetList: books,
      order: 'createdAt',
      bookCategory: category,
      page: 1,
      limit: 50,
    );
  }

  Future<void> getBooks({
    required RxList<Book> targetList,
    String? order,
    int? page,
    int? limit,
    BookCategory? bookCategory,
    String? search,
  }) async {
    isLoading.value = true;

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
      CustomBar.showError(err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getBook(String bookId) async {
    isLoading.value = true;

    try {
      final response = await bookService.getBook(bookId);
      chosenBook.value = response;
    } catch (err) {
      CustomBar.showError(err.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
