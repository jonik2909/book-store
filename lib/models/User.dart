class Member {
  final int id;
  final String nick;
  final String email;

  Member({
    required this.id,
    required this.nick,
    required this.email,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      nick: json['nick'],
      email: json['email'],
    );
  }
}
