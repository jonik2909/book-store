import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<dynamic> handleResponse(http.Response response) async {
  final body = jsonDecode(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    return body;
  } else {
    final errorMessage = body['message'] ?? 'Something went wrong!';
    throw errorMessage;
  }
}

extension EnumUtils on Enum {
  String get simpleName => toString().split('.').last;
}

String getImageUrl(String? path) {
  if (path == null || path.isEmpty) {
    return "";
  }
  return "${dotenv.env['UPLOAD_URL']}/$path";
}
