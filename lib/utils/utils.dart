import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

Map<String, String> getHeaders([String? token]) {
  print("token $token");
  final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }

  return headers;
}
