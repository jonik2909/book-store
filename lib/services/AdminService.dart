import 'package:book_store/models/Book.dart';
import 'package:book_store/models/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminService {
  static Future<List<Book>> getAdminBooks() async {
    final response = await http.get(
        Uri.parse('https://x8ki-letl-twmt.n7.xano.io/api:ESj5Rwpj/products'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  static Future<List<Member>> getAdminMembers() async {
    final response = await http.get(
        Uri.parse('https://x8ki-letl-twmt.n7.xano.io/api:ESj5Rwpj/members'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((member) => Member.fromJson(member)).toList();
    } else {
      throw Exception('Failed to load members');
    }
  }
}
