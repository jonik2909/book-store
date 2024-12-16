// Member Type and Status enums
enum MemberType { USER, AUTHOR, ADMIN }

enum MemberStatus { ACTIVE, BLOCK, DELETE }

// Member data model
class Member {
  final String id;
  final String memberNick;
  final MemberType memberType;
  final MemberStatus memberStatus;
  final String memberEmail;
  final int memberViews;
  final int memberLikes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Member({
    required this.id,
    required this.memberNick,
    required this.memberType,
    required this.memberStatus,
    required this.memberEmail,
    required this.memberViews,
    required this.memberLikes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['_id'],
      memberNick: json['memberNick'],
      memberType: MemberType.values.firstWhere(
        (e) => e.toString().split('.').last == json['memberType'],
      ),
      memberStatus: MemberStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['memberStatus'],
      ),
      memberEmail: json['memberEmail'],
      memberViews: json['memberViews'],
      memberLikes: json['memberLikes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'memberNick': memberNick,
      'memberType': memberType.toString().split('.').last,
      'memberStatus': memberStatus.toString().split('.').last,
      'memberEmail': memberEmail,
      'memberViews': memberViews,
      'memberLikes': memberLikes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
