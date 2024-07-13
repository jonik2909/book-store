// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/BookCard.dart';
import 'package:book_store/components/Category_card.dart';
import 'package:book_store/controller/controller.dart';
import 'package:book_store/pages/chosen_book_page.dart';
import 'package:book_store/pages/home_page.dart';
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

  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Color(0xffEB5757),
        unselectedItemColor: Color(0xff959CB0),
      ),
    );
  }
}
