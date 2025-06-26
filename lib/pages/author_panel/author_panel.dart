// ignore_for_file: prefer_const_constructors

import 'package:book_store/components/command/app_bar/custom_bar.dart';
import 'package:book_store/components/command/panel/router_card.dart';
import 'package:book_store/pages/author_panel/create_book.dart';
import 'package:book_store/pages/author_panel/author_books.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorPanel extends StatelessWidget {
  const AuthorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: "Author Panel", desc: "Manage your books"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            RouterCard(
              title: 'My Books',
              subtitle: 'View and manage your published books',
              icon: Icons.library_books,
              route: AuthorBooks(),
              color: Colors.red[700]!,
            ),
            SizedBox(height: 16),
            RouterCard(
              title: 'Add New Book',
              subtitle: 'Create and publish a new book',
              icon: Icons.add_circle,
              route: CreateBook(),
              color: Colors.red[700]!,
            ),
          ],
        ),
      ),
    );
  }
}
