class Member {
  final int id;
  final String nick;
  final String email;
  final String type;

  Member({
    required this.id,
    required this.nick,
    required this.email,
    required this.type,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      nick: json['nick'],
      email: json['email'],
      type: json['type'],
    );
  }
}
