import 'dart:io';

import 'package:book_store/models/book.dart';
import 'package:book_store/services/base_service.dart';
import 'package:book_store/utils/utils.dart';
import 'package:http/http.dart' as http;

class BookService extends BaseService {
  BookService();

  // getBooks
  Future<List<Book>> getBooks({
    String? order,
    int? page,
    int? limit,
    BookCategory? bookCategory,
    String? search,
  }) async {
    try {
      final response = await get(
        '/book/all',
        query: {
          if (order != null) 'order': order,
          if (page != null) 'page': page.toString(),
          if (limit != null) 'limit': limit.toString(),
          if (bookCategory != null) 'bookCategory': bookCategory.name,
          if (search != null) 'search': search,
        },
      );
      final List<dynamic> jsonData =
          await handleResponse(response) as List<dynamic>;

      return jsonData.map((book) => Book.fromJson(book)).toList();
    } catch (e) {
      throw Exception('Failed to fetch books: ${e.toString()}');
    }
  }

  // getBook
  Future<Book> getBook(String bookId) async {
    try {
      final response = await get('/book/$bookId');

      final body = await handleResponse(response) as Map<String, dynamic>;

      return Book.fromJson(body);
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
        Uri.parse('$baseUrl/book/create'),
      );

      // Add text fields
      request.fields.addAll({
        'bookName': bookName,
        'bookPrice': bookPrice.toString(),
        'bookDesc': bookDesc,
        'bookCategory': bookCategory.name,
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
      // Headers are now handled by client.sendMultipart
      var streamedResponse = await client.sendMultipart(request);
      var response = await http.Response.fromStream(streamedResponse);

      final body = await handleResponse(response) as Map<String, dynamic>;

      return Book.fromJson(body);
    } catch (e) {
      throw Exception('Failed to create book: ${e.toString()}');
    }
  }

  Future<List<Book>> getAuthorBooks() async {
    try {
      final response = await get('/book/my');

      final body = await handleResponse(response) as List<dynamic>;

      return body.map<Book>((book) => Book.fromJson(book)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deleteBook(String bookId) async {
    try {
      final response = await post(
        '/book/delete',
        {'_id': bookId},
      );

      await handleResponse(response);
      return true;
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
        Uri.parse('$baseUrl/book/update'),
      );

      // Add text fields
      request.fields['_id'] = id;
      if (bookName != null) request.fields['bookName'] = bookName;
      if (bookPrice != null) request.fields['bookPrice'] = bookPrice;
      if (bookDesc != null) request.fields['bookDesc'] = bookDesc;
      if (bookCategory != null) {
        request.fields['bookCategory'] = bookCategory.name;
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
      // Headers are now handled by client.sendMultipart
      var streamedResponse = await client.sendMultipart(request);
      var response = await http.Response.fromStream(streamedResponse);

      final body = await handleResponse(response) as Map<String, dynamic>;

      return Book.fromJson(body);
    } catch (e) {
      throw Exception('Failed to update book data: ${e.toString()}');
    }
  }

  // ADMIN API
  Future<List<Book>> getAllBooks() async {
    try {
      final response = await get('/admin/book/all');

      final body = await handleResponse(response) as List<dynamic>;

      return body.map<Book>((book) => Book.fromJson(book)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> removeBook(String bookId) async {
    try {
      final response = await post(
        '/admin/book/delete',
        {'_id': bookId},
      );

      await handleResponse(response);
      return true;
    } catch (e) {
      throw e.toString();
    }
  }
}
