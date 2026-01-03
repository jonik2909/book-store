// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/controllers/controller.dart';
import 'package:book_store/controllers/member_controller.dart';
import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/models/member.dart';
import 'package:book_store/pages/admin_panel/admin_panel.dart';
import 'package:book_store/pages/author_panel/author_panel.dart';
import 'package:book_store/pages/books/books_page.dart';
import 'package:book_store/pages/authors/authors_page.dart';
import 'package:book_store/pages/home/home_page.dart';
import 'package:book_store/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // Getters to allowing dynamic checking of memberType
  // while keeping the structure clean as requested
  List<Widget> get _widgetOptions {
    final MemberController memberController = Get.find<MemberController>();
    final baseScreens = <Widget>[
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

  List<BottomNavigationBarItem> _items(BuildContext context) {
    final MemberController memberController = Get.find<MemberController>();
    final list = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: AppLocalizations.of(context)!.home,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.library_books),
        label: AppLocalizations.of(context)!.books,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people_alt),
        label: AppLocalizations.of(context)!.authors,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: AppLocalizations.of(context)!.profile,
      ),
    ];

    if (memberController.authMember.value?.memberType == MemberType.ADMIN) {
      list.add(
        BottomNavigationBarItem(
          icon: Icon(Icons.admin_panel_settings),
          label: AppLocalizations.of(context)!.admin,
        ),
      );
    } else if (memberController.authMember.value?.memberType ==
        MemberType.AUTHOR) {
      list.add(
        BottomNavigationBarItem(
          icon: Icon(Icons.admin_panel_settings),
          label: AppLocalizations.of(context)!.author,
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find<Controller>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => _widgetOptions[controller.currentScreen.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          elevation: 0,
          items: _items(context),
          currentIndex: controller.currentScreen.value,
          selectedItemColor: Color(0xffEB5757),
          unselectedItemColor: Color(0xff959CB0),
          onTap: (value) => controller.changeScreen(value),
        ),
      ),
    );
  }
}
