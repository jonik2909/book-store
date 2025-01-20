// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/controller/controller.dart';
import 'package:book_store/controller/member.controller.dart';
import 'package:book_store/models/Member.dart';
import 'package:book_store/pages/admin_panel/admin_panel.dart';
import 'package:book_store/pages/author_panel/author_panel.dart';
import 'package:book_store/pages/books/books_page.dart';
import 'package:book_store/pages/authors/authors_page.dart';
import 'package:book_store/pages/home/home_page.dart';
import 'package:book_store/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());
    final MemberController memberController = Get.put(MemberController());

    // Create screens list dynamically based on user type
    List<Widget> getScreens() {
      final baseScreens = [
        HomePage(),
        BooksPage(),
        AuthorsPage(),
        ProfilePage(),
      ];

      if (memberController.authMember.value?.memberType == MemberType.ADMIN) {
        baseScreens.add(AdminPanel());
      } else if (memberController.authMember.value?.memberType ==
          MemberType.AUTHOR) {
        baseScreens.add(AuthorPanel());
      }

      return baseScreens;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      body: Obx(() => getScreens()[controller.currentScreen.value]),
      bottomNavigationBar: Obx(() {
        final items = <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'BOOKS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'AUTHORS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'PROFILE',
          ),
        ];

        // Add the appropriate panel based on user type
        if (memberController.authMember.value?.memberType == MemberType.ADMIN) {
          items.add(BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'ADMIN',
          ));
        } else if (memberController.authMember.value?.memberType ==
            MemberType.AUTHOR) {
          items.add(BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'AUTHOR',
          ));
        }

        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          elevation: 0,
          items: items,
          currentIndex: controller.currentScreen.value,
          selectedItemColor: Color(0xffEB5757),
          unselectedItemColor: Color(0xff959CB0),
          onTap: (value) => controller.changeScreen(value),
        );
      }),
    );
  }
}
