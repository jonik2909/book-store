// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/BookCard.dart';
import 'package:book_store/pages/chosen_book_page.dart';
import 'package:book_store/controller/new.book.controller.dart';
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
        title: Text(
          'Book Store',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 30),
            padding: EdgeInsets.only(right: 10),
          )
        ],
      ),
      drawer: Drawer(),
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
                    Row(
                      children: [
                        Text(
                          "See all",
                          style: TextStyle(
                            color: Color(0xffEB5757),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Color(0xffEB5757),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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

                    return Wrap(
                      direction: Axis.horizontal,
                      spacing: 16,
                      runSpacing: 16,
                      children: bookController.topBooks.map((book) {
                        return BookCard(
                          onTap: () => Get.to(
                            () => ChosenBookPage(),
                            arguments: {
                              'bookId': book.id,
                            },
                          ),
                          bookName: book.bookName,
                          bookAuthor: book.authorData.memberNick,
                          bookPrice: book.bookPrice,
                          bookViews: book.bookViews,
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
