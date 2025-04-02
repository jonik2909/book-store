// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/author_home_card.dart';
import 'package:book_store/components/book_card.dart';
import 'package:book_store/components/eventsSection.dart';
import 'package:book_store/controller/member.controller.dart';
import 'package:book_store/models/Member.dart';
import 'package:book_store/pages/authors/chosen_author_page.dart';
import 'package:book_store/pages/books/chosen_book_page.dart';
import 'package:book_store/controller/book.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final BookController bookController = Get.put(BookController());
  final MemberController memberController = Get.put(MemberController());

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
        child: Obx(() {
          if (bookController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            children: [
              // Only show Top Books section if there are books
              if (bookController.topBooks.isNotEmpty)
                Column(
                  children: [
                    Container(
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
                          Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bookController.topBooks.length,
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        itemBuilder: (context, index) {
                          final book = bookController.topBooks[index];
                          return BookCard(
                            onTap: () => Get.to(() => ChosenBookPage(),
                                    arguments: {'bookId': book.id})!
                                .then((_) =>
                                    bookController.refreshHomePageData()),
                            bookName: book.bookName,
                            bookAuthor: '${book.authorData?.memberNick}',
                            bookPrice: book.bookPrice,
                            bookViews: book.bookViews,
                            bookCategory:
                                book.bookCategory.toString().split('.').last,
                            width:
                                (MediaQuery.of(context).size.width - 100) / 2,
                            height: 200,
                            imageNetwork:
                                '${dotenv.env['UPLOAD_URL']}/${book.bookImages[0]}',
                          );
                        },
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 30),

              if (bookController.topBooks.isNotEmpty)
                Column(
                  children: [
                    Container(
                      height: 50,
                      color: Color.fromARGB(229, 248, 248, 248),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Authors",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: memberController.topAuthors
                            .length, // Assuming you have a topAuthors list
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        itemBuilder: (context, index) {
                          final author = memberController.topAuthors[index];
                          return AuthorHomeCard(
                            onTap: () => Get.to(() => AuthorDetailPage(),
                                arguments: {'memberId': author.id})?.then(
                              (_) => memberController.getAuthorList(
                                  targetList: memberController.topAuthors,
                                  order: 'createdAt',
                                  page: 1,
                                  limit: 100,
                                  memberType: MemberType.AUTHOR),
                            ),
                            name: author.memberNick,
                            email: author.memberEmail,
                            bookCount: 0,
                            viewsCount: author.memberViews,
                            photoUrl: author.memberImage,
                            width:
                                (MediaQuery.of(context).size.width - 100) / 2,
                          );
                        },
                      ),
                    )
                  ],
                ),
              SizedBox(height: 30),
              EventsSection(),
              SizedBox(height: 30),
              SizedBox(height: 15),
            ],
          );
        }),
      ),
    );
  }
}
