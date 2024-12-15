// Enum definitions
enum BookCategory {
  fiction,
  nonFiction,
  science,
  history,
  // Add other categories as per your BookCategory enum
}

enum BookStatus {
  process,
  approved,
  rejected,
  // Add other statuses as per your BookStatus enum
}

class NewBook {
  final String? id;
  final String bookName;
  final double bookPrice;
  final String bookDesc;
  final List<String> bookImages;
  final BookCategory bookCategory;
  final BookStatus bookStatus;
  final String memberId;
  final int bookViews;
  final int bookLikes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NewBook({
    this.id,
    required this.bookName,
    required this.bookPrice,
    required this.bookDesc,
    required this.bookImages,
    required this.bookCategory,
    this.bookStatus = BookStatus.process,
    required this.memberId,
    this.bookViews = 0,
    this.bookLikes = 0,
    this.createdAt,
    this.updatedAt,
  });

  // Convert from JSON
  factory NewBook.fromJson(Map<String, dynamic> json) {
    return NewBook(
      id: json['_id'],
      bookName: json['bookName'],
      bookPrice: json['bookPrice'],
      bookDesc: json['bookDesc'],
      bookImages: List<String>.from(json['bookImages']),
      bookCategory: BookCategory.values[json['bookCategory']],
      bookStatus: BookStatus.values[json['bookStatus']],
      memberId: json['memberId'],
      bookViews: json['bookViews'],
      bookLikes: json['bookLikes'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
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
    };
  }

  // Copy with method for immutability
  NewBook copyWith({
    String? id,
    String? bookName,
    double? bookPrice,
    String? bookDesc,
    List<String>? bookImages,
    BookCategory? bookCategory,
    BookStatus? bookStatus,
    String? memberId,
    int? bookViews,
    int? bookLikes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NewBook(
      id: id ?? this.id,
      bookName: bookName ?? this.bookName,
      bookPrice: bookPrice ?? this.bookPrice,
      bookDesc: bookDesc ?? this.bookDesc,
      bookImages: bookImages ?? this.bookImages,
      bookCategory: bookCategory ?? this.bookCategory,
      bookStatus: bookStatus ?? this.bookStatus,
      memberId: memberId ?? this.memberId,
      bookViews: bookViews ?? this.bookViews,
      bookLikes: bookLikes ?? this.bookLikes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
