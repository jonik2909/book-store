import 'dart:convert';
import 'dart:io';
import 'package:book_store/models/Book.dart';
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
  Future<List<Book>> getBooks({
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
          'bookCategory': bookCategory.toString().split('.').last,
        if (search != null) 'search': search,
      };

      final uri =
          Uri.parse('$_baseUrl/book/all').replace(queryParameters: queryParams);

      final response = await _client.get(
        uri,
        headers: await getHeaders(),
      );
      final List<dynamic> jsonData = await handleListResponse(response);

      return jsonData.map((book) => Book.fromJson(book)).toList();
    } catch (e) {
      throw Exception('Failed to fetch books: ${e.toString()}');
    }
  }

  // getBook
  Future<Book> getBook(String bookId) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/book/$bookId'),
        headers: await getHeaders(),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Book.fromJson(body);
      } else {
        final errorMessage = body['message'] ?? 'Something went wrong!';
        throw errorMessage;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  //createBook
  Future<Book> createBook({
    required String bookName,
    required int bookPrice,
    required String bookDesc,
    required BookCategory bookCategory,
    List<File>? bookImages,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/book/create'),
      );

      // Add text fields
      request.fields.addAll({
        'bookName': bookName,
        'bookPrice': bookPrice.toString(),
        'bookDesc': bookDesc,
        'bookCategory': bookCategory.toString().split('.').last,
      });

      // Add multiple images if they exist
      if (bookImages != null && bookImages.isNotEmpty) {
        for (var i = 0; i < bookImages.length; i++) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'bookImages', // Using array notation in field name
              bookImages[i].path,
            ),
          );
        }
      }

      // Add headers
      var headers = await getHeaders();
      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Book.fromJson(body);
      } else {
        final errorMessage = body['message'] ?? 'Something went wrong!';
        throw errorMessage;
      }
    } catch (e) {
      throw Exception('Failed to create book: ${e.toString()}');
    }
  }

  Future<List<Book>> getAuthorBooks() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/book/my'),
        headers: await getHeaders(),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return body.map<Book>((book) => Book.fromJson(book)).toList();
      } else {
        final errorMessage = body['message'] ?? 'Something went wrong!';
        throw errorMessage;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deleteBook(String bookId) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/book/delete'),
        headers: await getHeaders(),
        body: jsonEncode({'_id': bookId}),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final errorMessage = body['message'] ?? 'Something went wrong!';
        throw errorMessage;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Book> updateBook({
    required String id,
    String? bookName,
    String? bookPrice,
    String? bookDesc,
    BookCategory? bookCategory,
    List<File>? bookImages,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/book/update'),
      );

      // Add text fields
      request.fields['_id'] = id;
      if (bookName != null) request.fields['bookName'] = bookName;
      if (bookPrice != null) request.fields['bookPrice'] = bookPrice;
      if (bookDesc != null) request.fields['bookDesc'] = bookDesc;
      if (bookCategory != null) {
        request.fields['bookCategory'] =
            bookCategory.toString().split('.').last;
      }

      // Add the image if it exists
      // Add multiple images if they exist
      if (bookImages != null && bookImages.isNotEmpty) {
        for (var i = 0; i < bookImages.length; i++) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'bookImages', // Using array notation in field name
              bookImages[i].path,
            ),
          );
        }
      }

      // Add headers
      var headers = await getHeaders();
      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Book.fromJson(body);
      } else {
        final errorMessage = body['message'] ?? 'Something went wrong!';
        throw errorMessage;
      }
    } catch (e) {
      throw Exception('Failed to update book data: ${e.toString()}');
    }
  }

  // ADMIN API
  Future<List<Book>> getAllBooks() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/admin/book/all'),
        headers: await getHeaders(),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return body.map<Book>((book) => Book.fromJson(book)).toList();
      } else {
        final errorMessage = body['message'] ?? 'Something went wrong!';
        throw errorMessage;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> removeBook(String bookId) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/admin/book/delete'),
        headers: await getHeaders(),
        body: jsonEncode({'_id': bookId}),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final errorMessage = body['message'] ?? 'Something went wrong!';
        throw errorMessage;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
