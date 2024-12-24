// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/controller/author.controller.dart';
import 'package:book_store/models/NewBook.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class CreateBook extends StatelessWidget {
  const CreateBook({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthorController authorController = Get.put(AuthorController());
    final List<BookCategory> _categories = BookCategory.values;

    // controllers
    final bookName = TextEditingController();
    final bookPrice = TextEditingController();
    final bookDesc = TextEditingController();
    final bookCategory = TextEditingController();

    void handleSubmit() async {
      try {
        if (bookName.text.isEmpty ||
            bookPrice.text.isEmpty ||
            bookDesc.text.isEmpty ||
            bookCategory.text.isEmpty) {
          Get.snackbar(
            'Error',
            'Please fill all fields',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        final price = int.tryParse(bookPrice.text);
        if (price == null || price <= 0) {
          Get.snackbar(
            'Error',
            'Please enter a valid price',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        // Convert string category to enum
        final category = BookCategory.values.firstWhere(
          (cat) => cat.toString().split('.').last == bookCategory.text,
          orElse: () => BookCategory.OTHER,
        );

        await authorController.createBook({
          'bookName': bookName.text,
          'bookPrice': price,
          'bookDesc': bookDesc.text,
          'bookCategory': category,
          'bookImages': authorController.selectedImages.isNotEmpty
              ? authorController.selectedImages.toList()
              : null,
        });

        // Show success message
        Get.snackbar(
          'Success',
          'Book created successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // // Add a small delay before navigation
        // await Future.delayed(Duration(milliseconds: 1000));
        Navigator.pop(context);
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Add book',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 50),
            child: Column(
              children: [
                SizedBox(height: 20),
                inputField(
                  label: 'Book Name',
                  controller: bookName,
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                inputField(
                  label: 'Book Price',
                  controller: bookPrice,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                inputField(
                  label: 'Book Description',
                  controller: bookDesc,
                  maxLines: 3,
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.04),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: bookCategory.text.isEmpty ? null : bookCategory.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff8E8E93),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    hint: Text('Select Category'),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        bookCategory.text = newValue;
                      }
                    },
                    items:
                        _categories.map<DropdownMenuItem<String>>((category) {
                      final value = category.toString().split('.').last;
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.04),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Obx(() => authorController.selectedImages.isEmpty
                      ? GestureDetector(
                          onTap: authorController.pickMultipleImages,
                          child: Image.asset(
                            'lib/assets/upload_img.png',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: authorController
                                        .selectedImages.length +
                                    (authorController.selectedImages.length < 3
                                        ? 1
                                        : 0),
                                itemBuilder: (context, index) {
                                  if (index ==
                                      authorController.selectedImages.length) {
                                    // Add more button (only shown if less than 3 images)
                                    return GestureDetector(
                                      onTap:
                                          authorController.pickMultipleImages,
                                      child: Container(
                                        width: 150,
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add_photo_alternate,
                                                size: 40),
                                            Text(
                                                'Add More\n(${3 - authorController.selectedImages.length} left)'),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  return Stack(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 200,
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: FileImage(
                                              authorController
                                                  .selectedImages[index],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            authorController.removeImage(index);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Upload up to 3 images (${authorController.selectedImages.length}/3)',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        )),
                ),
                SizedBox(height: 20),
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: authorController.isLoading.value
                            ? null
                            : handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffEB5757),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: authorController.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Add Book',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required Function(String) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: label,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff8E8E93),
          )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
