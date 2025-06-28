// ignore_for_file: prefer_const_constructors

import 'package:book_store/components/command/app_bar/custom_bar.dart';
import 'package:book_store/controllers/author_controller.dart';
import 'package:book_store/models/book.dart';
import 'package:book_store/utils/custom_bar.dart';
import 'package:book_store/validators/book_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBook extends StatelessWidget {
  const CreateBook({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // Form key qo'shdim

    final AuthorController authorController = Get.put(AuthorController());
    const List<BookCategory> categories = BookCategory.values;

    // controllers
    final bookName = TextEditingController();
    final bookPrice = TextEditingController();
    final bookDesc = TextEditingController();
    final bookCategory = TextEditingController();

    Future<void> handleSubmit() async {
      if (!formKey.currentState!.validate()) {
        return;
      }

      final imageError =
          BookValidator.validateImages(authorController.selectedImages);
      if (imageError != null) {
        CustomBar.showError(imageError);
        return;
      }

      final price = int.tryParse(bookPrice.text);
      if (price == null || price <= 0) {
        CustomBar.showError('Please enter a valid price');

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
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar:
          CustomAppBar(title: "Create New Book", desc: "Add your book details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book Images',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Obx(() => authorController.selectedImages.isEmpty
                      ? GestureDetector(
                          onTap: authorController.pickMultipleImages,
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.blue[200]!),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate,
                                    size: 48, color: Colors.blue[400]),
                                SizedBox(height: 8),
                                Text(
                                  'Upload Book Images',
                                  style: TextStyle(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Upload up to 3 images',
                                  style: TextStyle(
                                    color: Colors.blue[400],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : _buildImageList(authorController)),
                ),
                SizedBox(height: 24),
                Text(
                  'Book Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 12),
                _buildInputField(
                  label: 'Book Name',
                  controller: bookName,
                  prefixIcon: Icons.book,
                  validator: BookValidator.validateBookName,
                ),
                SizedBox(height: 16),
                _buildInputField(
                  label: 'Price (\$)',
                  controller: bookPrice,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.attach_money,
                  validator: BookValidator.validatePrice,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: bookCategory.text.isEmpty ? null : bookCategory.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.category, color: Colors.blue[700]),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red[400]!, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  hint: Text('Select Category'),
                  items: categories.map<DropdownMenuItem<String>>((category) {
                    final value = category.toString().split('.').last;
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: BookValidator.validateCategory,
                  onChanged: (String? newValue) {
                    if (newValue != null) bookCategory.text = newValue;
                  },
                ),
                SizedBox(height: 16),
                _buildInputField(
                  label: 'Description',
                  controller: bookDesc,
                  maxLines: 4,
                  prefixIcon: Icons.description,
                  validator: BookValidator.validateDescription,
                ),
                SizedBox(height: 32),
                Obx(() => SizedBox(
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
                        child: authorController.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Publish Book',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    )),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required IconData prefixIcon,
    String? Function(String?)? validator, // To'g'ri validator type
  }) {
    return TextFormField(
      // TextField o'rniga TextFormField
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,

      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: Colors.blue[700]),
        hintText: label,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red[400]!, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red[400]!, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildImageList(AuthorController controller) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.selectedImages.length +
                (controller.selectedImages.length < 3 ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.selectedImages.length) {
                return GestureDetector(
                  onTap: controller.pickMultipleImages,
                  child: Container(
                    width: 150,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate,
                            size: 32, color: Colors.blue[400]),
                        SizedBox(height: 8),
                        Text(
                          '${3 - controller.selectedImages.length} more',
                          style: TextStyle(color: Colors.blue[700]),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  Container(
                    width: 150,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: FileImage(controller.selectedImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red[400]),
                      onPressed: () => controller.removeImage(index),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
