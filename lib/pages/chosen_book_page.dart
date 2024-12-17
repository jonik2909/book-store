import 'package:book_store/controller/new.book.controller.dart';
import 'package:book_store/models/NewBook.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ChosenBookPage extends GetView<NewBookController> {
  const ChosenBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String bookId = Get.arguments['bookId'] as String;
    controller.getBook(bookId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
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
                  decoration: const BoxDecoration(
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
                      height: 350.0,
                      enlargeCenterPage: true,
                    ),
                    items: book.bookImages.map((img) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                '${dotenv.env['UPLOAD_URL']}/$img',
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(child: Icon(Icons.error));
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ),
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
                      book.authorData.memberNick,
                      style: const TextStyle(
                        color: Color(0xff9D9D9D),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
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
                        onPressed: () {},
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
                                'Download',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.download,
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
