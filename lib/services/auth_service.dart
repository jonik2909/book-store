import 'dart:convert';

import 'package:book_store/models/member.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  late final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Map<String, String>> getHeaders([String? token]) async {
    final token = await getToken();

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<void> saveToken(String token, Member member) async {
    final prefs = await _prefs;
    await prefs.setString('accessToken', token);
    await prefs.setString('memberData', jsonEncode(member.toJson()));
  }

  Future<String?> getToken() async {
    final prefs = await _prefs;
    return prefs.getString('accessToken');
  }

  Future<String?> getMemberData() async {
    final prefs = await _prefs;
    return prefs.getString('memberData');
  }

  Future<void> clearStorage() async {
    final prefs = await _prefs;
    await prefs.remove('accessToken');
    await prefs.remove('memberData');
  }
}
