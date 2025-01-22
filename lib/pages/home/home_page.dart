// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/book_card.dart';
import 'package:book_store/pages/books/chosen_book_page.dart';
import 'package:book_store/controller/book.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final NewBookController bookController = Get.put(NewBookController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookController.refreshHomePageData();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book Store',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.red,
                fontSize: 24,
              ),
            ),
            Text(
              'All for you',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15), // Right padding
            child: Icon(
              Icons.menu_book_rounded,
              color: Colors.red,
              size: 20,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => bookController.refreshHomePageData(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 50,
                color: Color.fromARGB(229, 248, 248, 248),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Books",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: Obx(() {
                    if (bookController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Wrap(
                      direction: Axis.horizontal,
                      spacing: 16,
                      runSpacing: 16,
                      children: bookController.topBooks.map((book) {
                        return BookCard(
                          onTap: () => Get.to(() => ChosenBookPage(),
                                  arguments: {'bookId': book.id})!
                              .then(
                                  (_) => bookController.refreshHomePageData()),
                          bookName: book.bookName,
                          bookAuthor: '${book.authorData?.memberNick}',
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
      ),
    );
  }
}
