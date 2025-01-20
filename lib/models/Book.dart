// Enum definitions

import 'package:book_store/models/Member.dart';

enum BookCategory {
  FANTASY,
  HISTORY,
  HORROR,
  OTHER,
}

enum BookStatus { PROCESS, PAUSE }

class NewBook {
  final String? id;
  final String bookName;
  final int bookPrice;
  final String bookDesc;
  final List<String> bookImages;
  final BookCategory bookCategory;
  final BookStatus bookStatus;
  final String memberId;
  final int bookViews;
  final int bookLikes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Member? authorData;

  NewBook({
    this.id,
    required this.bookName,
    required this.bookPrice,
    required this.bookDesc,
    required this.bookImages,
    required this.bookCategory,
    required this.bookStatus,
    required this.memberId,
    this.bookViews = 0,
    this.bookLikes = 0,
    this.createdAt,
    this.updatedAt,
    required this.authorData,
  });

  factory NewBook.fromJson(Map<String, dynamic> json) {
    return NewBook(
      id: json['_id'],
      bookName: json['bookName'],
      bookPrice: json['bookPrice'],
      bookDesc: json['bookDesc'],
      bookImages: List<String>.from(json['bookImages']),
      bookCategory:
          _parseBookCategory(json['bookCategory']), // Parse string to enum
      bookStatus: _parseBookStatus(json['bookStatus']), // Parse string to enum
      memberId: json['memberId'],
      bookViews: json['bookViews'] ?? 0,
      bookLikes: json['bookLikes'] ?? 0,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      authorData: json['authorData'] != null
          ? Member.fromJson(json['authorData'] as Map<String, dynamic>)
          : null,
    );
  }

  // Helper method to parse BookCategory
  static BookCategory _parseBookCategory(String category) {
    try {
      return BookCategory.values.firstWhere(
        (e) => e.name == category, // Use .name instead of toString().split()
        orElse: () => BookCategory.OTHER,
      );
    } catch (e) {
      return BookCategory.OTHER;
    }
  }

  // Helper method to parse BookStatus
  static BookStatus _parseBookStatus(String status) {
    try {
      return BookStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => BookStatus.PROCESS,
      );
    } catch (e) {
      return BookStatus.PROCESS;
    }
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookName': bookName,
      'bookPrice': bookPrice,
      'bookDesc': bookDesc,
      'bookImages': bookImages,
      'bookCategory': bookCategory.index,
      'bookStatus': bookStatus.index,
      'memberId': memberId,
      'bookViews': bookViews,
      'bookLikes': bookLikes,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'authorData': authorData?.toJson(),
    };
  }
}
