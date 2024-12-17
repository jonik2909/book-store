import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> handleResponse(http.Response response) async {
  final body = jsonDecode(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    return body;
  } else {
    final errorMessage = body['message'] ?? 'Something went wrong!';
    throw errorMessage;
  }
}

Future<List<dynamic>> handleListResponse(http.Response response) async {
  final body = jsonDecode(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    return body;
  } else {
    final errorMessage = body['message'] ?? 'Something went wrong!';
    throw errorMessage;
  }
}

Future<Map<String, String>> getHeaders([String? token]) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('accessToken');

  final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }

  return headers;
}
