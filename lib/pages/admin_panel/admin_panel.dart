// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/app_bar/custom_bar.dart';
import 'package:book_store/components/panel/router_card.dart';
import 'package:book_store/pages/admin_panel/admin_books.dart';
import 'package:book_store/pages/admin_panel/admin_members.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: CustomAppBar(title: "Admin Panel", desc: "Manage system"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              RouterCard(
                title: 'All Books',
                subtitle: 'View and manage all published books',
                icon: Icons.library_books,
                route: AdminBooks(),
                color: Colors.red[700]!,
              ),
              SizedBox(height: 16),
              RouterCard(
                title: 'All Members',
                subtitle: 'View and manage all members',
                icon: Icons.supervised_user_circle_sharp,
                route: AdminMembers(),
                color: Colors.red[700]!,
              ),
            ],
          ),
        ));
  }
}
