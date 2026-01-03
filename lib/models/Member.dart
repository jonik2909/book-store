// ignore_for_file: constant_identifier_names
// Member Type and Status enums
import 'package:book_store/models/book.dart';

enum MemberType { USER, AUTHOR, ADMIN }

enum MemberStatus { ACTIVE, BLOCK, DELETE }

// Member data model
class Member {
  final String id;
  final String memberNick;
  final MemberType memberType;
  final MemberStatus memberStatus;
  final String memberEmail;
  final String? memberDesc;
  final String? memberImage;
  final int memberViews;
  final int memberBooks;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Book>? bookData;

  Member({
    required this.id,
    required this.memberNick,
    required this.memberType,
    required this.memberStatus,
    required this.memberEmail,
    required this.memberDesc,
    required this.memberImage,
    required this.memberViews,
    required this.memberBooks,
    required this.createdAt,
    required this.updatedAt,
    required this.bookData,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['_id'],
      memberNick: json['memberNick'],
      memberType: MemberType.values.byName(json['memberType']),
      memberStatus: MemberStatus.values.byName(json['memberStatus']),
      memberEmail: json['memberEmail'],
      memberDesc: json['memberDesc'] ?? '',
      memberImage: json['memberImage'] ?? '',
      memberViews: json['memberViews'],
      memberBooks: json['memberBooks'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      bookData: json['bookData'] != null
          ? List<Book>.from(json['bookData'].map((x) => Book.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'memberNick': memberNick,
      'memberType': memberType.name,
      'memberStatus': memberStatus.name,
      'memberEmail': memberEmail,
      'memberDesc': memberDesc,
      'memberImage': memberImage,
      'memberViews': memberViews,
      'memberBooks': memberBooks,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
