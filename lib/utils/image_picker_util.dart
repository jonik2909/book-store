// lib/utils/image_picker_util.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'dart:io';

class ImagePickerUtil {
  static final ImagePicker _picker = ImagePicker();

  // Single image picker
  static Future<File?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 80,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: imageQuality,
      );

      if (pickedFile == null) return null;

      return File(pickedFile.path);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xffEB5757),
        colorText: const Color(0xffffffff),
      );
      return null;
    }
  }

  // Multiple images picker
  static Future<List<File>> pickMultiImage({
    int imageQuality = 80,
  }) async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: imageQuality,
      );

      return pickedFiles.map((file) => File(file.path)).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick images: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xffEB5757),
        colorText: const Color(0xffffffff),
      );
      return [];
    }
  }
}
