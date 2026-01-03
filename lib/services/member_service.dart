import 'dart:convert';
import 'dart:io';
import 'package:book_store/models/member.dart';

import 'package:book_store/utils/client.dart';
import 'package:book_store/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MemberService {
  final String _baseUrl = dotenv.env['API_URL']!;
  final Client _client = Client();

  MemberService();

  void dispose() {
    _client.close();
  }

  // Login
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/member/login'),
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
    required bool isAuthor,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/member/signup'),
        body: jsonEncode({
          'memberNick': username,
          'memberEmail': email,
          'memberPassword': password,
          'memberType': isAuthor
              ? MemberType.AUTHOR.toString().split('.').last
              : MemberType.USER.toString().split('.').last
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
      );

      return handleResponse(response);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // getUserDetails
  Future<Map<String, dynamic>> getUserDetails(String token) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/auth/me'),
      );

      return handleResponse(response);
    } catch (e) {
      throw Exception('Failed to get user details: ${e.toString()}');
    }
  }

  // updateUserData
  Future<Map<String, dynamic>> updateUserData({
    required String? nick,
    required String? email,
    required String? desc,
    File? memberImage,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/member/update'),
      );

      // Add text fields
      if (nick != null) request.fields['memberNick'] = nick;
      if (email != null) request.fields['memberEmail'] = email;
      if (desc != null) request.fields['memberDesc'] = desc;

      // Add the image if it exists
      if (memberImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'memberImage',
            memberImage.path,
          ),
        );
      }

      // Headers are now handled by _client.sendMultipart
      var streamedResponse = await _client.sendMultipart(request);
      var response = await http.Response.fromStream(streamedResponse);

      return handleResponse(response);
    } catch (e) {
      throw Exception('Failed to update user data: ${e.toString()}');
    }
  }

  Future<List<Member>> getMembers({
    String? order,
    int? page,
    int? limit,
    MemberType? memberType,
    String? search,
  }) async {
    try {
      final queryParams = {
        if (order != null) 'order': order,
        if (page != null) 'page': page.toString(),
        if (limit != null) 'limit': limit.toString(),
        if (memberType != null)
          'memberType': memberType.toString().split('.').last,
        if (search != null) 'search': search,
      };

      final uri = Uri.parse('$_baseUrl/member/all')
          .replace(queryParameters: queryParams);

      final response = await _client.get(
        uri,
      );
      final List<dynamic> jsonData = await handleListResponse(response);

      return jsonData.map((book) => Member.fromJson(book)).toList();
    } catch (e) {
      throw Exception('Failed to fetch books: ${e.toString()}');
    }
  }

  Future<Member> getMember(String memberId) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/member/$memberId'),
      );

      final body = await handleResponse(response);

      return Member.fromJson(body);
    } catch (e) {
      rethrow;
    }
  }

  // ADMIN API
  Future<List<Member>> getAllBooks() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/admin/member/all'),
      );

      final body = await handleListResponse(response);

      return body.map<Member>((book) => Member.fromJson(book)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> removeMember(String memberId) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/admin/member/delete'),
        body: jsonEncode({'_id': memberId}),
      );

      await handleResponse(response);

      return true;
    } catch (e) {
      throw e.toString();
    }
  }
}
