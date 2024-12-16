// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/models/Book.dart';
import 'package:book_store/models/NewBook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ChosenBookPage extends StatelessWidget {
  ChosenBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewBook book = Get.arguments as NewBook;
    print("book $book");
    print("arguments ${book.authorData.memberNick}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        spreadRadius: 0,
                        blurRadius: 14,
                        offset: Offset(7, 0),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      '${dotenv.env['UPLOAD_URL']}/${book.bookImages[0]}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Column(
                  children: [
                    Text(
                      "${book.bookName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff19191B),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "${book.authorData.memberNick}",
                      style: TextStyle(
                        color: Color(0xff9D9D9D),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       "About the Author",
              //       style: TextStyle(
              //         color: Color(0xff19191B),
              //         fontSize: 18,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //     SizedBox(height: 10),
              //     Text(
              //       "book.bookAuthorDesc",
              //       style: TextStyle(
              //         color: Color(0xff9D9D9D),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Overview",
                    style: TextStyle(
                      color: Color(0xff19191B),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${book.bookDesc}",
                    style: TextStyle(
                      color: Color(0xff9D9D9D),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                height: 55,
                margin: const EdgeInsets.only(top: 10, bottom: 50),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffEB5757),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Download',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.download,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
