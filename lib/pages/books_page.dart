// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/BookCard.dart';
import 'package:book_store/components/Category_card.dart';
import 'package:book_store/controller/new.book.controller.dart';
import 'package:book_store/models/NewBook.dart';
import 'package:book_store/pages/chosen_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class BooksPage extends StatelessWidget {
  BooksPage({super.key});

  final List<BookCategory> _categories = BookCategory.values;
  final NewBookController bookController = Get.put(NewBookController());

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   bookController.getBookPagedata(BookCategory.FANTASY);
    //   bookController.changeCategory(BookCategory.FANTASY);
    // });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Books',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.search, size: 30),
        //     padding: EdgeInsets.only(right: 10),
        //   )
        // ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return GestureDetector(
                      onTap: () => {
                        bookController.getBookPagedata(category),
                        bookController.changeCategory(category)
                      },
                      child: Obx(() => CategoryCard(
                            name: category.toString().split('.').last,
                            selected: category ==
                                bookController.selectedCategory.value,
                          )),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              child: Center(
                child: Obx(() {
                  if (bookController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (bookController.errorMessage.isNotEmpty) {
                    return Center(
                        child: Text(bookController.errorMessage.value));
                  }

                  if (bookController.books.isEmpty) {
                    return Center(
                      child: Text(
                        'No data found!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    );
                  }

                  return Wrap(
                    direction: Axis.horizontal,
                    spacing: 16,
                    runSpacing: 16,
                    children: bookController.books.map((book) {
                      return BookCard(
                        onTap: () => Get.to(() => ChosenBookPage(),
                                arguments: {'bookId': book.id})!
                            .then((_) => bookController.getBookPagedata(
                                bookController.selectedCategory.value)),
                        bookName: book.bookName,
                        bookAuthor: book.authorData.memberNick,
                        bookPrice: book.bookPrice,
                        bookViews: book.bookViews,
                        bookCategory:
                            book.bookCategory.toString().split('.').last,
                        width: (MediaQuery.of(context).size.width - 60) / 2,
                        height: 200,
                        imageNetwork:
                            '${dotenv.env['UPLOAD_URL']}/${book.bookImages[0]}',
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
