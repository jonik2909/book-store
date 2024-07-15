// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/controller/admin.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class CreateBook extends StatelessWidget {
  const CreateBook({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminController adminController = Get.put(AdminController());

    final items = <String>['HISTORY', 'HORROR', 'FANTASY', 'OTHER'];

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
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                inputField(
                  label: 'Book Price',
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                inputField(
                  label: 'book Desc',
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                inputField(
                  label: 'bookAuthor',
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                inputField(
                  label: 'bookAuthorDesc',
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                Obx(
                  () => Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.04),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: adminController.bookCategory.value.isEmpty
                          ? null
                          : adminController.bookCategory.value,
                      hint: Text('Select Category'),
                      onChanged: (String? newValue) {
                        adminController.bookCategory.value = newValue!;
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Obx(
                  () => adminController.bookImage.value.isEmpty
                      ? GestureDetector(
                          onTap: adminController.pickImage,
                          child: Image.asset(
                            'lib/assets/upload_img.png',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.file(
                          height: 250,
                          File(adminController.bookImage.value),
                        ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffEB5757),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Border radius
                      ),
                    ),
                    child: Text(
                      'Add Book',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required Function(String) onChanged,
    // controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        // controller: controller,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
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
