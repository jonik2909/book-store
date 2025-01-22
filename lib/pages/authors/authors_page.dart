// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/author_card.dart';
import 'package:book_store/controller/member.controller.dart';
import 'package:book_store/models/Member.dart';
import 'package:book_store/pages/authors/chosen_author_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorsPage extends StatelessWidget {
  AuthorsPage({super.key});

  final MemberController memberController = Get.put(MemberController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      memberController.getAuthorList(
          order: 'createdAt',
          page: 1,
          limit: 100,
          memberType: MemberType.AUTHOR);
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
              'Authors',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.red,
                fontSize: 24,
              ),
            ),
            Text(
              'Meet the authors',
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
                    Obx(() {
                      if (memberController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (memberController.authorList.isEmpty) {
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
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        runSpacing: 20,
                        children: memberController.authorList.map((author) {
                          return AuthorCard(
                              memberNick: author.memberNick,
                              memberEmail: author.memberEmail,
                              memberImage: author.memberImage,
                              memberViews: author.memberViews,
                              onTap: () => Get.to(() => AuthorDetailPage(),
                                      arguments: {'memberId': author.id})
                                  ?.then((_) => memberController.getAuthorList(
                                      order: 'createdAt',
                                      page: 1,
                                      limit: 100,
                                      memberType: MemberType.AUTHOR)));
                        }).toList(),
                      );
                    })
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
