import 'package:book_store/services/auth_service.dart';
import 'package:http/http.dart' as http;

class Client extends http.BaseClient {
  final http.Client _inner = http.Client();
  final AuthService authService = AuthService();

  Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final headers = await authService.getHeaders();
    request.headers.addAll(headers);
    return _inner.send(request);
  }
}
