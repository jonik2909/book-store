// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/components/command/app_bar/detail_bar.dart';
import 'package:book_store/components/command/book/book_card.dart';
import 'package:book_store/pages/books/chosen_book_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_store/controller/member.controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:share_plus/share_plus.dart';

class AuthorDetailPage extends StatelessWidget {
  AuthorDetailPage({super.key});

  final MemberController memberController = Get.put(MemberController());

  void _shareAuthorProfile(
      String authorName, String email, int books, int views) {
    final String shareText = '''
Check out this author on Book Store!

👤 Author: $authorName
✉️ Email: $email
📚 Published Books: $books
👀 Total Views: $views
''';
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String memberId = Get.arguments['memberId'] as String;
      memberController.getMember(memberId);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DetailBar(
        onPressed: () {
          final author = memberController.chosenAuthor.value;
          if (author != null) {
            _shareAuthorProfile(
              author.memberNick,
              author.memberEmail,
              author.bookData?.length ?? 0,
              author.memberViews,
            );
          }
        },
      ),
      body: Obx(() {
        if (memberController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final author = memberController.chosenAuthor.value;
        if (author == null) {
          return const Center(child: Text('Author topilmadi'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      if (author.memberImage != null &&
                          author.memberImage!.isNotEmpty)
                        InstaImageViewer(
                          imageUrl:
                              '${dotenv.env['UPLOAD_URL']}/${author.memberImage}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${dotenv.env['UPLOAD_URL']}/${author.memberImage}',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey[200],
                                  child: Text(
                                    author.memberNick[0].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
                          child: Text(
                            author.memberNick[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      SizedBox(height: 16),
                      Text(
                        author.memberNick,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        author.memberEmail,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32),

                // Stats Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('Views', author.memberViews.toString()),
                      _buildStatColumn(
                          'Books', author.bookData?.length.toString() ?? '0'),
                    ],
                  ),
                ),

                SizedBox(height: 32),

                // Books Section
                Text(
                  'Published Books',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),

                // Books List
                if (author.bookData == null || author.bookData!.isEmpty)
                  Center(
                    child: Text(
                      'No data found!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                else
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 16,
                    runSpacing: 16,
                    children: author.bookData!.map((book) {
                      return BookCard(
                        onTap: () {
                          Get.to(
                            () => ChosenBookPage(),
                            arguments: {'bookId': book.id},
                          );
                        },
                        bookName: book.bookName,
                        bookAuthor: author.memberNick,
                        bookPrice: book.bookPrice,
                        bookViews: book.bookViews,
                        bookCategory:
                            book.bookCategory.toString().split('.').last,
                        width: (MediaQuery.of(context).size.width - 60) / 2,
                        height: 200,
                        imageNetwork: book.bookImages.isNotEmpty
                            ? '${dotenv.env['UPLOAD_URL']}/${book.bookImages[0]}'
                            : '',
                      );
                    }).toList(),
                  ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget _buildStatColumn(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
    ],
  );
}
