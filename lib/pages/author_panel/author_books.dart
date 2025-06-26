// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:book_store/components/app_bar/custom_bar.dart';
import 'package:book_store/controller/author.controller.dart';
import 'package:book_store/pages/author_panel/edit_book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class AuthorBooks extends StatelessWidget {
  AuthorBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthorController authorController = Get.put(AuthorController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: "My Books", desc: "Controll your books"),
      body: Obx(
        () => Visibility(
          visible: authorController.authorBooks.isNotEmpty,
          replacement: Center(
            child: Text(
              'No Books Published Yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          child: GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: authorController.authorBooks.length,
            itemBuilder: (context, index) {
              var book = authorController.authorBooks[index];

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book Image
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                          child: CachedNetworkImage(
                            imageUrl:
                                '${dotenv.env['UPLOAD_URL']}/${book.bookImages[0]}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Book Details
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.bookName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${book.bookPrice}',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => EditBookPage(book: book));
                                },
                                child: Icon(Icons.edit_outlined, size: 20),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final result = await Get.dialog(
                                    AlertDialog(
                                      title: Text('Delete Book'),
                                      content: Text('Are you sure?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Get.back(result: false),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Get.back(result: true),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (result == true) {
                                    await authorController
                                        .deleteBook(book.id.toString());
                                  }
                                },
                                child: Icon(Icons.delete_outline,
                                    size: 20, color: Colors.red[400]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
