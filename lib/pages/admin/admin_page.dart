// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/pages/admin/books.dart';
import 'package:book_store/pages/admin/members.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            'Admin Page',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              // _buildRouterTile(context, 'Books', Icons.store, Books()),
              // _buildRouterTile(
              //     context, 'Add new Book', Icons.add_box, CreateBook()),
              // _buildRouterTile(context, 'Users', Icons.people, Members()),
            ],
          ),
        ));
  }

  Widget _buildRouterTile(
      BuildContext context, String title, IconData icon, Widget route) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            spreadRadius: 1.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Color(0xffEB5757)),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward, color: Color(0xffEB5757)),
        onTap: () {
          Get.to(() => route);
        },
      ),
    );
  }
}
