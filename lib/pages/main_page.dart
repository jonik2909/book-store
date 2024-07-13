// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/controller/controller.dart';
import 'package:book_store/pages/explore_page.dart';
import 'package:book_store/pages/favorite_page.dart';
import 'package:book_store/pages/home_page.dart';
import 'package:book_store/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final List<String> _categories = [
    'Fantasy',
    'History',
    'Horror',
    'Humor',
  ];

  final List<Widget> _screens = [
    HomePage(),
    ExplorePage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      body: Obx(() => _screens[controller.currentScreen.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'EXPLORE',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'FAVORITE',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'PROFILE',
              ),
            ],
            currentIndex: controller.currentScreen.value,
            selectedItemColor: Color(0xffEB5757),
            unselectedItemColor: Color(0xff959CB0),
            onTap: (value) => controller.changeScreen(value),
          )),
    );
  }
}
