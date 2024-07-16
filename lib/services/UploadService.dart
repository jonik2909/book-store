import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class UploadService {
  static Future uploadImage(File imageFile) async {
    final uri = Uri.parse(
        "https://x8ki-letl-twmt.n7.xano.io/api:ESj5Rwpj/upload/image");

    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        await http.MultipartFile.fromPath(
          'content',
          imageFile.path,
        ),
      );

    final response = await request.send();
    final responseBody = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final jsonResponse = await json.decode(responseBody.body);
      return 'https://x8ki-letl-twmt.n7.xano.io' + jsonResponse['path'];
    } else {
      throw Exception('Failed to upload image!');
    }
  }
}
