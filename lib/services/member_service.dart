import 'dart:convert';
import 'dart:io';
import 'package:book_store/models/member.dart';
import 'package:book_store/services/auth_service.dart';
import 'package:book_store/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MemberService {
  final String _baseUrl;
  final http.Client _client;
  final AuthService authService = AuthService();

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
        headers: await authService.getHeaders(),
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
        headers: await authService.getHeaders(),
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
        headers: await authService.getHeaders(),
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
        headers: await authService.getHeaders(),
      );

      return handleResponse(response);
    } catch (e) {
      throw Exception('Failed to get user details: ${e.toString()}');
    }
  }

  // Update user data
  // Future<Map<String, dynamic>> updateUserData({
  //   required String token,
  //   required int id,
  //   required String nick,
  //   required String email,
  // }) async {
  //   try {
  //     final response = await _client.post(
  //       Uri.parse('$_baseUrl/members/$id'),
  //       headers: await getHeaders(),
  //       body: jsonEncode({
  //         'id': id,
  //         'nick': nick,
  //         'email': email,
  //       }),
  //     );

  //     return handleResponse(response);
  //   } catch (e) {
  //     throw Exception('Failed to update user data: ${e.toString()}');
  //   }
  // }

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
        headers: await authService.getHeaders(),
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
        headers: await authService.getHeaders(),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Member.fromJson(body);
      } else {
        final errorMessage = body['message'] ?? 'Something went wrong!';
        throw errorMessage;
      }
    } catch (e) {
      print("error $e");
      throw e.toString();
    }
  }

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

      // Add headers
      var headers = await authService.getHeaders();
      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return handleResponse(response);
    } catch (e) {
      throw Exception('Failed to update user data: ${e.toString()}');
    }
  }

  // ADMIN API
  Future<List<Member>> getAllBooks() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/admin/member/all'),
        headers: await authService.getHeaders(),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return body.map<Member>((book) => Member.fromJson(book)).toList();
      } else {
        final errorMessage = body['message'] ?? 'Something went wrong!';
        throw errorMessage;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> removeMember(String memberId) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/admin/member/delete'),
        headers: await authService.getHeaders(),
        body: jsonEncode({'_id': memberId}),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final errorMessage = body['message'] ?? 'Something went wrong!';
        throw errorMessage;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
