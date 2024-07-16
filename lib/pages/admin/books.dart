// ignore_for_file: prefer_const_constructors

import 'package:book_store/controller/admin.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Books extends StatelessWidget {
  Books({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminController adminController = Get.put(AdminController());

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
      body: Obx(() => Visibility(
            visible: adminController.bookList.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Items',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: ListView.builder(
                itemCount: adminController.bookList.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  var book = adminController.bookList[index];

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            book.bookImage.toString(),
                            fit: BoxFit.cover,
                            width: 50.0, // Adjust the width as needed
                            height: 50.0,
                          ),
                        ),
                      ),
                      title: Text(book.bookName.toString()),
                      subtitle: Text(book.bookAuthor.toString()),
                      trailing: GestureDetector(
                        onTap: () async {
                          await adminController.deleteBook(book.id);
                          await adminController.getAdminBooks();
                        },
                        child: Icon(Icons.delete),
                      ),
                    ),
                  );
                }),
          )),
    );
  }
}
