import 'dart:convert';
import 'dart:io';
import 'package:book_store/services/auth_service.dart';
import 'package:book_store/models/member.dart';
import 'package:book_store/pages/main_page.dart';
import 'package:book_store/pages/splash/splash_page.dart';
import 'package:book_store/services/member_service.dart';
import 'package:book_store/utils/image_picker_util.dart';
import 'package:book_store/utils/custom_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberController extends GetxController {
  final memberService = MemberService();
  final authController = Get.find<AuthService>();

  final RxBool isLoading = false.obs;

  var authToken = ''.obs;
  var loginErrorMessage = ''.obs;
  var signupErrorMessage = ''.obs;
  var isAuthenticated = false.obs;
  final Rx<Member?> authMember = Rx<Member?>(null);

  /* HOME PAGE */
  final RxList<Member> topAuthors = <Member>[].obs;

  /* AUTHORS PAGE */
  final RxList<Member> authorList = <Member>[].obs;

  /* CHOSEN AUTHOR PAGE */
  final Rx<Member?> chosenAuthor = Rx<Member?>(null);

  /* PROFILE PAGE */
  Rx<File?> get thumnailImage => Rx<File?>(null);

  Future pickMemberImage() async {
    try {
      var img = await ImagePickerUtil.pickImage(source: ImageSource.gallery);

      if (img == null) return;

      thumnailImage.value = File(img.path);
    } catch (err) {
      CustomBar.showError(err.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
    checkLoginStatus();

    getAuthorList(
      targetList: authorList,
      order: 'memberViews',
      page: 1,
      limit: 100,
      memberType: MemberType.AUTHOR,
    );

    getAuthorList(
      targetList: topAuthors,
      order: 'memberBooks',
      page: 1,
      limit: 100,
      memberType: MemberType.AUTHOR,
    );
  }

  Future<void> checkLoginStatus() async {
    try {
      final token = await authController.getToken();
      if (token != null && token.isNotEmpty) {
        authToken.value = token;
        await getMyData();
        isAuthenticated.value = true;
        Get.offAll(() => const MainPage());
      } else {
        isAuthenticated.value = false;
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

      await authController.saveToken(authToken.value, authMember.value!);

      Get.offAll(() => const MainPage());
    } catch (e) {
      loginErrorMessage.value = e.toString();
    }
  }

  Future<void> signup(
      String username, String email, String password, bool isAuthor) async {
    try {
      var response = await memberService.signup(
        username: username,
        email: email,
        password: password,
        isAuthor: isAuthor,
      );

      authToken.value = response['accessToken'];
      authMember.value = Member.fromJson(response['member']);

      await authController.saveToken(authToken.value, authMember.value!);

      Get.offAll(() => const MainPage());
    } catch (e) {
      signupErrorMessage.value = e.toString();
    }
  }

  Future<void> logout() async {
    try {
      await memberService.logout(authToken.value);

      authToken.value = '';
      authMember.value = null;

      await authController.clearStorage();
    } catch (err) {
      CustomBar.showError(err.toString());
    }
  }

  Future<void> getMyData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final memberJson = prefs.getString('memberData');

      authMember.value = Member.fromJson(jsonDecode(memberJson!));
    } catch (err) {
      CustomBar.showError(err.toString());
    }
  }

  /* PROFILE PAGE */
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
      CustomBar.showSuccess('Profile updated successfully');
    } catch (err) {
      CustomBar.showError(err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /* HOME PAGE */
  Future<void> getAuthorList({
    required RxList<Member> targetList,
    String? order,
    int? page,
    int? limit,
    MemberType? memberType,
    String? search,
  }) async {
    try {
      isLoading.value = false;

      final members = await memberService.getMembers(
        order: order,
        page: page,
        limit: limit,
        memberType: memberType,
        search: search,
      );

      targetList.assignAll(members);
    } catch (err) {
      CustomBar.showError(err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /* CHOSEN AUTHOR PAGE */
  Future<void> getMember(String memberId) async {
    isLoading.value = true;

    try {
      final response = await memberService.getMember(memberId);

      chosenAuthor.value = response;
    } catch (err) {
      CustomBar.showError(err.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
