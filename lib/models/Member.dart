// Member Type and Status enums
import 'package:book_store/models/Book.dart';

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
  final int memberLikes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<NewBook>? bookData;

  Member({
    required this.id,
    required this.memberNick,
    required this.memberType,
    required this.memberStatus,
    required this.memberEmail,
    required this.memberDesc,
    required this.memberImage,
    required this.memberViews,
    required this.memberLikes,
    required this.createdAt,
    required this.updatedAt,
    required this.bookData,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['_id'],
      memberNick: json['memberNick'],
      memberType: parseMemberType(json['memberType']),
      memberStatus: parseMemberStatus(json['memberStatus']),
      memberEmail: json['memberEmail'],
      memberDesc: json['memberDesc'] ?? '',
      memberImage: json['memberImage'] ?? '',
      memberViews: json['memberViews'],
      memberLikes: json['memberLikes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      bookData: json['bookData'] != null
          ? List<NewBook>.from(json['bookData'].map((x) => NewBook.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'memberNick': memberNick,
      'memberType': memberType.toString().split('.').last,
      'memberStatus': memberStatus.toString().split('.').last,
      'memberEmail': memberEmail,
      'memberDesc': memberDesc,
      'memberImage': memberImage,
      'memberViews': memberViews,
      'memberLikes': memberLikes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'bookData': bookData?.map((book) => book.toJson()).toList()
    };
  }

  static MemberType parseMemberType(String type) {
    try {
      return MemberType.values.firstWhere(
        (e) => e.name == type,
      );
    } catch (e) {
      return MemberType.USER;
    }
  }

  static MemberStatus parseMemberStatus(String type) {
    try {
      return MemberStatus.values.firstWhere(
        (e) => e.name == type,
      );
    } catch (e) {
      return MemberStatus.ACTIVE;
    }
  }
}
