// ignore_for_file: prefer_const_constructors

import 'package:book_store/controller/admin.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Books extends StatelessWidget {
  const Books({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminController bookController = Get.put(AdminController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Book list',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Visibility(
        // visible: items.isNotEmpty,
        replacement: Center(
          child: Text(
            'No Items',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        child: ListView.builder(
            itemCount: bookController.bookList.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              var book = bookController.bookList[index];

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        "lib/assets/book.jpg",
                        fit: BoxFit.cover,
                        width: 50.0, // Adjust the width as needed
                        height: 50.0,
                      ),
                    ),
                  ),
                  title: Text(book.bookName.toString()),
                  subtitle: Text(book.bookAuthor.toString()),
                  trailing: Icon(Icons.delete),
                ),
              );
            }),
      ),
    );
  }
}
