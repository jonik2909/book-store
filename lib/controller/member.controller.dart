import 'dart:convert';

import 'package:book_store/models/User.dart';
import 'package:book_store/pages/main_page.dart';
import 'package:book_store/services/MemberService.dart';
import 'package:get/get.dart';

class MemberController extends GetxController {
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
      var response = await Memberservice.login(username, password);
      authToken.value = response['accessToken'];

      // await getUserDetails(response['accessToken']);

      Get.to(MainPage());
    } catch (e) {
      print("error >> $e");
      loginErrorMessage.value = e.toString();
    }
  }

  Future<void> signup(String nick, String username, String password) async {
    try {
      var response = await Memberservice.signup(nick, username, password);
      authToken.value = response['authToken'];

      await getUserDetails(response['authToken']);

      Get.to(MainPage());
    } catch (e) {
      print("error >> $e");
      signupErrorMessage.value = e.toString();
    }
  }

  Future<void> getUserDetails(String token) async {
    try {
      var response = await Memberservice.getUserDetails(token);
      print("member >> $response");

      member.value = Member.fromJson(response);
    } catch (e) {
      print("error >> $e");
    }
  }

  Future<void> updateUserData(
      String token, int id, String nick, String email) async {
    try {
      var response = await Memberservice.updateUserData(token, id, nick, email);
      member.value = Member.fromJson(response);
    } catch (e) {
      print("error >> $e");
      throw e;
    }
  }
}
