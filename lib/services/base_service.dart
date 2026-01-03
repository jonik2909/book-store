import 'dart:convert';
import 'package:book_store/utils/client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class BaseService {
  final String baseUrl = dotenv.env['API_URL']!;
  final Client client = Client();

  // GET Request
  Future<http.Response> get(String endpoint, {Map<String, dynamic>? query}) {
    Uri uri = Uri.parse("$baseUrl$endpoint");

    if (query != null) {
      final validQuery = <String, dynamic>{};
      query.forEach((key, value) {
        if (value != null) validQuery[key] = value.toString();
      });
      uri = uri.replace(queryParameters: validQuery);
    }

    return client.get(uri);
  }

  // POST Request
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) {
    final uri = Uri.parse("$baseUrl$endpoint");

    return client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
  }

  void dispose() {
    client.close();
  }
}
