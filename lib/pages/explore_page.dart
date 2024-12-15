// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/BookCard.dart';
import 'package:book_store/components/Category_card.dart';
import 'package:book_store/controller/book.controller.dart';
import 'package:book_store/controller/controller.dart';
import 'package:book_store/pages/chosen_book_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});

  final List<String> _categories = [
    'HISTORY',
    'HORROR',
    'FANTASY',
    'OTHER',
  ];

  @override
  Widget build(BuildContext context) {
    final BookController bookController = Get.put(BookController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Explore',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => {
                            bookController
                                .getBooksByCategory(_categories[index]),
                            bookController.changeCategory(index)
                          },
                          child: Obx(() => CategoryCard(
                                name: _categories[index],
                                selected: index ==
                                    bookController.selectedCategory.value,
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 10);
                      }),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Obx(
                      () => Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        runSpacing: 20,
                        children: bookController.bookList.map((book) {
                          // return BookCard(
                          //   onTap: () =>
                          //       Get.to(ChosenBookPage(), arguments: book),
                          //   imagePath: book.bookImage,
                          //   bookName: book.bookName,
                          //   bookAuthor: book.bookAuthor,
                          //   bookPrice: book.bookPrice,
                          //   width: 160,
                          //   height: 194,
                          //   imageNetwork: true,
                          // );
                          return Text("data");
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
