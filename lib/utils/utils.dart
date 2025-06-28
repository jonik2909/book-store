import 'dart:convert';
import 'package:http/http.dart' as http;

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
