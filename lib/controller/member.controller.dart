import 'dart:convert';

import 'package:book_store/models/User.dart';
import 'package:book_store/pages/home_page.dart';
import 'package:book_store/pages/login_page.dart';
import 'package:book_store/pages/main_page.dart';
import 'package:book_store/pages/splash_page.dart';
import 'package:book_store/services/MemberService.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberController extends GetxController {
  final memberService = MemberService();

  var authToken = ''.obs;
  var member = Member(id: 0, nick: '', email: '', type: '').obs;
  var loginErrorMessage = ''.obs;
  var signupErrorMessage = ''.obs;
  var isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      final token = await getToken();
      if (token != null && token.isNotEmpty) {
        authToken.value = token;
        // await getUserDetails(token);
        isAuthenticated.value = true;
        Get.offAll(() => MainPage());
      } else {
        isAuthenticated.value = false;
        Get.offAll(() => SplashPage());
      }
    } catch (e) {
      isAuthenticated.value = false;
      Get.offAll(() => SplashPage());
    }
  }

  Future<void> login(String username, String password) async {
    try {
      var response = await memberService.login(username, password);

      authToken.value = response['accessToken'];

      await _saveToken(authToken.value);

      Get.to(MainPage());
    } catch (e) {
      loginErrorMessage.value = e.toString();
    }
  }

  Future<void> signup(String username, String email, String password) async {
    try {
      var response = await memberService.signup(
          username: username, email: email, password: password);
      authToken.value = response['accessToken'];

      // await getUserDetails(response['authToken']);
      await _saveToken(authToken.value);

      Get.to(MainPage());
    } catch (e) {
      signupErrorMessage.value = e.toString();
    }
  }

  Future<void> logout() async {
    try {
      await memberService.logout(authToken.value);
      authToken.value = '';

      await _clearStorage();

      Get.to(SplashPage());
    } catch (e) {
      loginErrorMessage.value = e.toString();
    }
  }

  Future<void> getUserDetails(String token) async {
    try {
      var response = await memberService.getUserDetails(token);
      print("member >> $response");

      member.value = Member.fromJson(response);
    } catch (e) {
      print("error >> $e");
    }
  }

  Future<void> updateUserData(
      String token, int id, String nick, String email) async {
    try {
      // var response = await memberService.updateUserData(token, id, nick, email);
      // member.value = Member.fromJson(response);
    } catch (e) {
      print("error >> $e");
      throw e;
    }
  }

  Future<void> _saveToken(String token) async {
    print(token);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> _clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }
}
