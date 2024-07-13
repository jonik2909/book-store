import 'package:book_store/models/Book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bookservice {
  static Future<List<BookModel>> getBooks() async {
    final response = await http.get(
        Uri.parse('https://x8ki-letl-twmt.n7.xano.io/api:ESj5Rwpj/products'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => BookModel.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
