import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Memberservice {
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('${dotenv.env['API_URL']}/member/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'memberNick': username,
        'memberPassword': password,
      }),
    );

    print('Status Code: ${response.statusCode}');
    print('Body: ${response.body}');
    print('Headers: ${response.headers}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body);
      // throw Exception(error['message']); // Only throw the 'message'
      throw (error['message']);
    }
  }

  static Future<Map<String, dynamic>> signup(
      String nick, String username, String password) async {
    final response = await http.post(
      Uri.parse('https://x8ki-letl-twmt.n7.xano.io/api:ESj5Rwpj/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nick': nick,
        'email': username,
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

  static Future<Map<String, dynamic>> updateUserData(
      String token, int id, String nick, String email) async {
    final response = await http.post(
      Uri.parse(
          'https://x8ki-letl-twmt.n7.xano.io/api:ESj5Rwpj/members/{members_id}'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        'nick': nick,
        'email': email,
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
}
