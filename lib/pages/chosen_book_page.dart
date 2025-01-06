// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:typed_data';

import 'package:book_store/controller/book.controller.dart';
import 'package:book_store/pages/file_reader.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ChosenBookPage extends GetView<NewBookController> {
  const ChosenBookPage({super.key});

  void _shareBookDetails(String bookName, String authorName, String category,
      String price, String description) {
    final String shareText = '''
Check out this book on Book Store!

📚 $bookName
✍️ By: $authorName
📑 Category: $category
💰 Price: \$$price

📖 Description:
${description}
''';
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String bookId = Get.arguments['bookId'] as String;
      controller.getBook(bookId);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                final book = controller.chosenBook.value;
                if (book != null) {
                  _shareBookDetails(
                    book.bookName,
                    book.authorData?.memberNick ?? 'Unknown Author',
                    book.bookCategory.toString().split('.').last,
                    book.bookPrice.toString(),
                    book.bookDesc,
                  );
                }
              },
              icon: const Icon(
                Icons.share,
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final book = controller.chosenBook.value;
        if (book == null) {
          return const Center(child: Text('Kitob topilmadi'));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Rasm Carousel
              Center(
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        spreadRadius: 0,
                        blurRadius: 14,
                        offset: Offset(7, 0),
                      ),
                    ],
                  ),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      height: 350.0,
                      enlargeCenterPage: true,
                    ),
                    items: book.bookImages.map((img) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Stack(fit: StackFit.expand, children: [
                              InstaImageViewer(
                                imageUrl: '${dotenv.env['UPLOAD_URL']}/$img',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    '${dotenv.env['UPLOAD_URL']}/$img',
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                          child: Icon(Icons.error));
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '${book.bookViews.toString()} views',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              // Kitob haqida ma'lumot
              Center(
                child: Column(
                  children: [
                    Text(
                      book.bookName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xff19191B),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${book.authorData?.memberNick}',
                      style: const TextStyle(
                        color: Color(0xff9D9D9D),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // After the author name text widget, add this section:
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xffEB5757).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      book.bookCategory.toString().split('.').last,
                      style: const TextStyle(
                        color: Color(0xffEB5757),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '\$${book.bookPrice}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              // Overview qismi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Overview",
                      style: TextStyle(
                        color: Color(0xff19191B),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      book.bookDesc,
                      style: const TextStyle(
                        color: Color(0xff9D9D9D),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Download tugmasi
                    Container(
                      color: Colors.white,
                      height: 55,
                      margin: const EdgeInsets.only(top: 10, bottom: 50),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            // Load the EPUB file from assets
                            final ByteData data = await rootBundle
                                .load('lib/assets/books/book.epub');
                            final bytes = data.buffer.asUint8List();

                            // Get temporary directory to save the file
                            final tempDir = await getTemporaryDirectory();
                            final tempEpubPath =
                                '${tempDir.path}/temp_book.epub';

                            // Write the file
                            File(tempEpubPath).writeAsBytesSync(bytes);

                            // Navigate to the EPUB reader
                            Get.to(
                                () => EpubReaderPage(epubPath: tempEpubPath));
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              'Failed to load the book: ${e.toString()}',
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffEB5757),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Read Book',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.menu_book,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
