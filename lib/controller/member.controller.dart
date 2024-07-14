import 'package:book_store/models/Auth.dart';
import 'package:book_store/models/User.dart';
import 'package:book_store/pages/home_page.dart';
import 'package:book_store/pages/main_page.dart';
import 'package:book_store/services/MemberService.dart';
import 'package:get/get.dart';

class MemberController extends GetxController {
  var authToken = Auth(authToken: '').obs;
  var member = Member(id: 0, nick: '', email: '').obs;
  var errorMessage = ''.obs;

  Future<void> login(String email, String password) async {
    try {
      var response = await Memberservice.login(email, password);
      authToken.value = Auth.fromJson(response);
      Get.to(MainPage());
    } catch (e) {
      print("error >> $e");
      errorMessage.value = 'Username or password incorrect!';
    }
  }

  Future<void> getUserDetails(String token) async {
    var response = await Memberservice.getUserDetails(token);
    member.value = Member.fromJson(response);
  }
}
