// ignore_for_file: constant_identifier_names
// Enum definitions

import 'package:book_store/models/member.dart';

enum BookCategory {
  FANTASY,
  HISTORY,
  HORROR,
  OTHER,
}

enum BookStatus { PROCESS, PAUSE }

class Book {
  final String? id;
  final String bookName;
  final int bookPrice;
  final String bookDesc;
  final List<String> bookImages;
  final BookCategory bookCategory;
  final BookStatus bookStatus;
  final String memberId;
  final int bookViews;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Member? authorData;

  Book({
    this.id,
    required this.bookName,
    required this.bookPrice,
    required this.bookDesc,
    required this.bookImages,
    required this.bookCategory,
    required this.bookStatus,
    required this.memberId,
    this.bookViews = 0,
    this.createdAt,
    this.updatedAt,
    required this.authorData,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'],
      bookName: json['bookName'],
      bookPrice: json['bookPrice'],
      bookDesc: json['bookDesc'],
      bookImages: List<String>.from(json['bookImages']),
      bookCategory: BookCategory.values
          .byName(json['bookCategory']), // Parse string to enum
      bookStatus:
          BookStatus.values.byName(json['bookStatus']), // Parse string to enum
      memberId: json['memberId'],
      bookViews: json['bookViews'] ?? 0,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      authorData: json['authorData'] != null
          ? Member.fromJson(json['authorData'] as Map<String, dynamic>)
          : null,
    );
  }
}
