import 'package:book_store/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Client extends http.BaseClient {
  final http.Client _inner = http.Client();
  final AuthService authService = Get.find<AuthService>();

  Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final headers = await authService.getHeaders();
    request.headers.addAll(headers);
    return _inner.send(request);
  }

  // Helper for Multipart requests to reuse the same logic
  Future<http.StreamedResponse> sendMultipart(
      http.MultipartRequest request) async {
    final headers = await authService.getHeaders();
    request.headers.addAll(headers);
    return _inner.send(request);
  }
}
