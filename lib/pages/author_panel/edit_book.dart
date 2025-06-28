// ignore_for_file: prefer_const_constructors

import 'package:book_store/components/command/app_bar/custom_bar.dart';
import 'package:book_store/utils/validators/book_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_store/controller/author_controller.dart';
import 'package:book_store/models/book.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EditBookPage extends StatelessWidget {
  EditBookPage({super.key, required this.book});

  final Book book;
  final _formKey = GlobalKey<FormState>();
  final AuthorController authorController = Get.find();

  // Use RxString for form fields
  final RxString bookName = ''.obs;
  final RxString bookPrice = ''.obs;
  final RxString bookDesc = ''.obs;
  // Use Rx<BookCategory> for enum
  final Rx<BookCategory> selectedCategory = BookCategory.FANTASY.obs;

  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      bool hasCurrentImages = book.bookImages.isNotEmpty;
      bool hasNewImages = authorController.selectedImages.isNotEmpty;

      if (!hasCurrentImages && !hasNewImages) {
        Get.snackbar(
          'Error',
          'At least one image is required',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      authorController.updateBook(
        id: book.id.toString(),
        bookName: bookName.value,
        bookPrice: bookPrice.value,
        bookDesc: bookDesc.value,
        bookCategory: selectedCategory.value,
        bookImages: authorController.selectedImages.isNotEmpty
            ? authorController.selectedImages.toList()
            : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('category: ${book.bookCategory}');
    // Initialize values on build
    bookName.value = book.bookName;
    bookPrice.value = book.bookPrice.toString();
    bookDesc.value = book.bookDesc;
    selectedCategory.value = book.bookCategory;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: "Edit Book", desc: "Edit your book"),
      body: Obx(() => Stack(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book Name Field
                      TextFormField(
                        initialValue: bookName.value,
                        onChanged: (value) => bookName.value = value,
                        decoration: InputDecoration(
                          labelText: 'Book Name',
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(height: 0), // Error yashirish
                        ),
                        validator: BookValidator.validateBookName,
                      ),
                      SizedBox(height: 16),

                      // Book Price Field
                      TextFormField(
                        initialValue: bookPrice.value,
                        onChanged: (value) => bookPrice.value = value,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                          prefixText: '\$',
                          errorStyle: TextStyle(height: 0), // Error yashirish
                        ),
                        keyboardType: TextInputType.number,
                        validator: BookValidator.validatePrice,
                      ),
                      SizedBox(height: 16),

                      // Book Description Field
                      TextFormField(
                        initialValue: bookDesc.value,
                        onChanged: (value) => bookDesc.value = value,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(height: 0), // Error yashirish
                        ),
                        maxLines: 3,
                        validator: BookValidator.validateDescription,
                      ),
                      SizedBox(height: 16),

                      // Book Category Dropdown - BU YERDA XATOLIK BOR EDI
                      Obx(
                        () => DropdownButtonFormField<BookCategory>(
                          value: selectedCategory.value,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(height: 0), // Error yashirish
                          ),
                          items: BookCategory.values.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category.toString().split('.').last),
                            );
                          }).toList(),
                          validator: (BookCategory? value) =>
                              BookValidator.validateCategory(
                                  value.toString().split('.').last),
                          onChanged: (BookCategory? value) {
                            if (value != null) {
                              selectedCategory.value = value;
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 24),

                      // Current Images Section
                      if (book.bookImages.isNotEmpty) ...[
                        Text(
                          'Current Images',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: book.bookImages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    '${dotenv.env['UPLOAD_URL']}/${book.bookImages[index]}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey[300],
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey[200],
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                      ],

                      // New Images Section
                      Text(
                        'New Images',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: authorController.pickMultipleImages,
                            icon: Icon(Icons.add_photo_alternate),
                            label: Text('Add Images'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 8),
                          if (authorController.selectedImages.isNotEmpty)
                            TextButton.icon(
                              onPressed: authorController.clearImages,
                              icon: Icon(Icons.clear),
                              label: Text('Clear All'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Obx(() => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: authorController.selectedImages
                                .asMap()
                                .entries
                                .map((entry) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      entry.value,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () => authorController
                                          .removeImage(entry.key),
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          )),
                      SizedBox(height: 24),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: authorController.isLoading.value
                              ? null
                              : handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            authorController.isLoading.value
                                ? 'Updating...'
                                : 'Update Book',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (authorController.isLoading.value)
                Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          )),
    );
  }
}
