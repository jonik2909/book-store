import 'dart:convert';
import 'package:book_store/models/NewBook.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:book_store/utils/utils.dart';

class NewBookService {
  final String _baseUrl;
  final http.Client _client;

  NewBookService({http.Client? client})
      : _baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3003/book',
        _client = client ?? http.Client();

  // getBooks
  Future<List<NewBook>> getBooks({
    String? order,
    int? page,
    int? limit,
    BookCategory? bookCategory,
    String? search,
  }) async {
    try {
      final queryParams = {
        if (order != null) 'order': order,
        if (page != null) 'page': page.toString(),
        if (limit != null) 'limit': limit.toString(),
        if (bookCategory != null)
          'collection': bookCategory.toString().split('.').last,
        if (search != null) 'search': search,
      };

      final uri = Uri.parse('${_baseUrl}/book/all')
          .replace(queryParameters: queryParams);

      final response = await _client.get(uri);
      final List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData.map((book) => NewBook.fromJson(book)).toList();
    } catch (e) {
      print('Service error: $e');
      throw Exception('Failed to fetch books: ${e.toString()}');
    }
  } // updateBook
  // deleteBook
  // likeTargetBook
}
