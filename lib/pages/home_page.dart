// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/BookCard.dart';
import 'package:book_store/components/Category_card.dart';
import 'package:book_store/controller/controller.dart';
import 'package:book_store/controller/new.book.controller.dart';
import 'package:book_store/pages/chosen_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final NewBookController bookController = Get.put(NewBookController());

  final List<String> _categories = [
    'Fantasy',
    'History',
    'Horror',
    'Humor',
  ];

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: SizedBox(
              //     height: 40,
              //     child: ListView.separated(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: _categories.length,
              //         itemBuilder: (context, index) {
              //           return GestureDetector(
              //             onTap: () => controller.changeCategory(index),
              //             child: Obx(() => CategoryCard(
              //                   name: _categories[index],
              //                   selected:
              //                       index == controller.selectedCategory.value,
              //                 )),
              //           );
              //         },
              //         separatorBuilder: (context, index) {
              //           return SizedBox(width: 10);
              //         }),
              //   ),
              // ),
              SizedBox(height: 25),
              Container(
                height: 50,
                color: Color(0xffF8F9FA),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 310,
                  child: Obx(() {
                    if (bookController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (bookController.errorMessage.isNotEmpty) {
                      return Center(
                          child: Text(bookController.errorMessage.value));
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookController.topBooks.length,
                      itemBuilder: (context, index) {
                        final book = bookController.topBooks[index];
                        return BookCard(
                          onTap: () => Get.to(ChosenBookPage()),

                          bookName: book.bookName,
                          bookAuthor:
                              'Author Name', // Add author field to your model if needed
                          bookPrice: book.bookPrice,
                          width: 130,
                          height: 194,
                          imageNetwork:
                              '${dotenv.env['UPLOAD_URL']}/${book.bookImages[0]}', // true if using network image
                        );
                      },
                    );
                  }),
                ),
              ),
              SizedBox(height: 25),
              Container(
                height: 50,
                color: Color(0xffF8F9FA),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending Now",
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
              ),
              SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: SizedBox(
              //     height: 310,
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: 10,
              //       itemBuilder: (context, index) {
              //         return BookCard(
              //           onTap: () => Get.to(ChosenBookPage()),
              //           bookName: 'Displacement',
              //           bookAuthor: 'Kiku Hughes',
              //           bookPrice: 16,
              //           width: 130,
              //           height: 194,
              //           imageNetwork: "lib/assets/book.jpg",
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
