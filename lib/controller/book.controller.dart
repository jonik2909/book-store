import 'package:book_store/services/BookService.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  // category
  var selectedCategory = 0.obs;
  void changeCategory(int index) {
    selectedCategory.value = index;
  }

  var bookList = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getBooksByCategory('HISTORY');
  }

  Future<void> getBooksByCategory(category) async {
    try {
      isLoading(true);
      var books = await Bookservice.getBooksByCategory(category);
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
