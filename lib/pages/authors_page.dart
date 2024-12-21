// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/AuthorCard.dart';
import 'package:book_store/components/BookCard.dart';
import 'package:book_store/controller/controller.dart';
import 'package:book_store/pages/chosen_book_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorsPage extends StatelessWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Authors',
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 20,
                      children: [
                        AuthorCard(
                          authorName: "authorName",
                          email: "email",
                          views: 2,
                          likes: 2,
                          onTap: () {},
                        ),
                        AuthorCard(
                          authorName: "authorName",
                          email: "email",
                          views: 2,
                          likes: 2,
                          onTap: () {},
                        ),
                      ],
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
