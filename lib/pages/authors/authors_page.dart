// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/app_bar/custom_bar.dart';
import 'package:book_store/components/authors/author_card.dart';
import 'package:book_store/controllers/member_controller.dart';
import 'package:book_store/models/member.dart';
import 'package:book_store/pages/authors/chosen_author_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorsPage extends StatelessWidget {
  AuthorsPage({super.key});

  final MemberController memberController = Get.put(MemberController());

  Future<void> refreshData() async {
    // Convert the void return type to Future<void>
    await memberController.getAuthorList(
      targetList: memberController.authorList,
      order: 'memberViews',
      page: 1,
      limit: 100,
      memberType: MemberType.AUTHOR,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshData();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Authors", desc: "Meet the authors"),
      body: RefreshIndicator(
        onRefresh: () => refreshData(),
        child: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
          Padding(
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
                                  arguments: {'memberId': author.id})?.then(
                                (_) {
                                  memberController.getAuthorList(
                                    targetList: memberController.authorList,
                                    order: 'memberViews',
                                    page: 1,
                                    limit: 100,
                                    memberType: MemberType.AUTHOR,
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
