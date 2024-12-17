import 'dart:convert';
import 'package:book_store/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MemberService {
  final String _baseUrl;
  final http.Client _client;

  MemberService({http.Client? client})
      : _baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3003/book',
        _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  // Login
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/member/login'),
        headers: await getHeaders(),
        body: jsonEncode({
          'memberNick': username,
          'memberPassword': password,
        }),
      );

      return handleResponse(response);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Signup
  Future<Map<String, dynamic>> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/member/signup'),
        headers: await getHeaders(),
        body: jsonEncode({
          'memberNick': username,
          'memberEmail': email,
          'memberPassword': password,
        }),
      );

      return handleResponse(response);
    } catch (e) {
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  // logout
  Future<Map<String, dynamic>> logout(String token) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/member/logout'),
        headers: await getHeaders(),
      );

      return handleResponse(response);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Get user details
  Future<Map<String, dynamic>> getUserDetails(String token) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/auth/me'),
        headers: await getHeaders(),
      );

      return handleResponse(response);
    } catch (e) {
      throw Exception('Failed to get user details: ${e.toString()}');
    }
  }

  // Update user data
  Future<Map<String, dynamic>> updateUserData({
    required String token,
    required int id,
    required String nick,
    required String email,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/members/$id'),
        headers: await getHeaders(),
        body: jsonEncode({
          'id': id,
          'nick': nick,
          'email': email,
        }),
      );

      return handleResponse(response);
    } catch (e) {
      throw Exception('Failed to update user data: ${e.toString()}');
    }
  }
}
