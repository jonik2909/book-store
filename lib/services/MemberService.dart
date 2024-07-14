import 'dart:convert';
import 'package:http/http.dart' as http;

class Memberservice {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('https://x8ki-letl-twmt.n7.xano.io/api:ESj5Rwpj/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<Map<String, dynamic>> signup(
      String nick, String email, String password) async {
    final response = await http.post(
      Uri.parse('https://x8ki-letl-twmt.n7.xano.io/api:ESj5Rwpj/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nick': nick,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorResponse = jsonDecode(response.body);
      final errorMessage = errorResponse['message'];
      throw Exception(errorMessage);
    }
  }

  static Future<Map<String, dynamic>> getUserDetails(String token) async {
    final response = await http.get(
      Uri.parse('https://x8ki-letl-twmt.n7.xano.io/api:ESj5Rwpj/auth/me'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw jsonDecode(response.body);
    }
  }
}
