import 'dart:convert';
import 'dart:io';

import 'package:book_store/controller/controller.dart';
import 'package:book_store/models/Member.dart';
import 'package:book_store/pages/main_page.dart';
import 'package:book_store/pages/splash/splash_page.dart';
import 'package:book_store/services/MemberService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberController extends GetxController {
  final memberService = MemberService();

  final RxBool isLoading = false.obs;

  var authToken = ''.obs;
  // var member = Member(id: id, memberNick: memberNick, memberType: memberType, memberStatus: memberStatus, memberEmail: memberEmail, memberDesc: memberDesc, memberViews: memberViews, memberLikes: memberLikes, createdAt: createdAt, updatedAt: updatedAt, bookData: bookData).obs;
  var loginErrorMessage = ''.obs;
  var signupErrorMessage = ''.obs;
  var isAuthenticated = false.obs;
  final Rx<Member?> authMember = Rx<Member?>(null);

  // Home Page
  final RxList<Member> authorList = <Member>[].obs;

  // Chosen Author Page
  final Rx<Member?> chosenAuthor = Rx<Member?>(null);

  @override
  void onReady() {
    super.onReady();
    checkLoginStatus();

    getAuthorList(
        order: 'createdAt', page: 1, limit: 100, memberType: MemberType.AUTHOR);
  }

  Future<void> checkLoginStatus() async {
    try {
      final token = await getToken();
      if (token != null && token.isNotEmpty) {
        authToken.value = token;
        await getMyData();
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
      authMember.value = Member.fromJson(response['member']);

      await _saveToken(authToken.value, authMember.value!);

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
      authMember.value = Member.fromJson(response['member']);

      await _saveToken(authToken.value, authMember.value!);

      Get.to(MainPage());
    } catch (e) {
      signupErrorMessage.value = e.toString();
    }
  }

  Future<void> logout() async {
    try {
      await memberService.logout(authToken.value);
      authToken.value = '';

      final Controller controller = Get.put(Controller());

      // Reset the screen to HOME before logging out
      controller.resetScreen();

      await _clearStorage();

      Get.to(SplashPage());
    } catch (err) {
      Get.snackbar(
        'Error',
        err.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getMyData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final memberJson = prefs.getString('memberData');

      authMember.value = Member.fromJson(jsonDecode(memberJson!));
    } catch (err) {
      Get.snackbar(
        'Error',
        err.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateUserData({
    required String? memberNick,
    required String? memberEmail,
    required String? memberDesc,
    File? memberImage,
  }) async {
    try {
      isLoading.value = true;

      // Get the member ID from current authMember
      if (authMember.value == null) {
        throw Exception('No authenticated member found');
      }

      final response = await memberService.updateUserData(
        nick: memberNick,
        email: memberEmail,
        desc: memberDesc,
        memberImage: memberImage,
      );

      // Update the auth member with new data
      authMember.value = Member.fromJson(response);

      // Show success update
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (err) {
      // Show error message
      Get.snackbar(
        'Error',
        err.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAuthorList({
    String? order,
    int? page,
    int? limit,
    MemberType? memberType,
    String? search,
  }) async {
    print("getAuthorsData");

    try {
      final members = await memberService.getMembers(
        order: order,
        page: page,
        limit: limit,
        memberType: memberType,
        search: search,
      );

      authorList.assignAll(members);
    } catch (err) {
      Get.snackbar(
        'Error',
        err.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getMember(String memberId) async {
    isLoading.value = true;

    try {
      final response = await memberService.getMember(memberId);

      chosenAuthor.value = response;
    } catch (err) {
      Get.snackbar(
        'Error',
        err.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveToken(String token, Member member) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    await prefs.setString('memberData', jsonEncode(member.toJson()));
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> _clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('memberData');
  }
}
