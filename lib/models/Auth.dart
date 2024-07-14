class Auth {
  final String authToken;

  Auth({required this.authToken});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      authToken: json['authToken'],
    );
  }
}
