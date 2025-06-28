// lib/utils/image_picker_util.dart

import 'package:book_store/utils/custom_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
      CustomBar.showError('Failed to pick image: ${e.toString()}');

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
      CustomBar.showError('Failed to pick images: ${e.toString()}');
      return [];
    }
  }
}
