import 'dart:convert';

import 'package:book_store/models/User.dart';
import 'package:book_store/pages/login_page.dart';
import 'package:book_store/pages/main_page.dart';
import 'package:book_store/services/MemberService.dart';
import 'package:get/get.dart';

class MemberController extends GetxController {
  final memberService = MemberService();

  var authToken = ''.obs;
  var member = Member(id: 0, nick: '', email: '', type: '').obs;
  var loginErrorMessage = ''.obs;
  var signupErrorMessage = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   getUserDetails(authToken.value.toString());
  // }

  Future<void> login(String username, String password) async {
    try {
      var response = await memberService.login(username, password);
      authToken.value = response['accessToken'];

      // await getUserDetails(response['accessToken']);

      Get.to(MainPage());
    } catch (e) {
      loginErrorMessage.value = e.toString();
    }
  }

  Future<void> signup(String username, String phone, String password) async {
    try {
      var response = await memberService.signup(
          username: username, phone: phone, password: password);
      authToken.value = response['authToken'];

      await getUserDetails(response['authToken']);

      Get.to(MainPage());
    } catch (e) {
      print("error >> $e");
      signupErrorMessage.value = e.toString();
    }
  }

  Future<void> logout() async {
    try {
      await memberService.logout(authToken.value);
      authToken.value = '';

      Get.to(LoginPage());
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
}
