import 'dart:io';

import 'package:book_store/models/member.dart';
import 'package:book_store/services/base_service.dart';
import 'package:book_store/utils/utils.dart';
import 'package:http/http.dart' as http;

class MemberService extends BaseService {
  MemberService();

  // Login
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await post(
        '/member/login',
        {
          'memberNick': username,
          'memberPassword': password,
        },
      );

      return await handleResponse(response) as Map<String, dynamic>;
    } catch (e) {
      rethrow;
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
      final response = await post(
        '/member/signup',
        {
          'memberNick': username,
          'memberEmail': email,
          'memberPassword': password,
          'memberType': isAuthor ? 'AUTHOR' : 'USER',
        },
      );

      return await handleResponse(response) as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  // logout
  Future<Map<String, dynamic>> logout(String token) async {
    try {
      final response = await get('/member/logout');

      return await handleResponse(response) as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  // getUserDetails
  Future<Map<String, dynamic>> getUserDetails(String token) async {
    try {
      final response = await get('/auth/me');

      return await handleResponse(response) as Map<String, dynamic>;
    } catch (e) {
      rethrow;
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
        Uri.parse('$baseUrl/member/update'),
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

      // Headers are now handled by client.sendMultipart
      var streamedResponse = await client.sendMultipart(request);
      var response = await http.Response.fromStream(streamedResponse);

      return await handleResponse(response) as Map<String, dynamic>;
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
      final response = await get(
        '/member/all',
        query: {
          if (order != null) 'order': order,
          if (page != null) 'page': page.toString(),
          if (limit != null) 'limit': limit.toString(),
          if (memberType != null)
            'memberType': memberType.toString().split('.').last,
          if (search != null) 'search': search,
        },
      );
      final List<dynamic> jsonData =
          await handleResponse(response) as List<dynamic>;

      return jsonData.map((book) => Member.fromJson(book)).toList();
    } catch (e) {
      throw Exception('Failed to fetch books: ${e.toString()}');
    }
  }

  Future<Member> getMember(String memberId) async {
    try {
      final response = await get('/member/$memberId');

      final body = await handleResponse(response) as Map<String, dynamic>;

      return Member.fromJson(body);
    } catch (e) {
      rethrow;
    }
  }

  // ADMIN API
  Future<List<Member>> getAllBooks() async {
    try {
      final response = await get('/admin/member/all');

      final body = await handleResponse(response) as List<dynamic>;

      return body.map<Member>((book) => Member.fromJson(book)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> removeMember(String memberId) async {
    try {
      final response = await post(
        '/admin/member/delete',
        {'_id': memberId},
      );

      await handleResponse(response);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
