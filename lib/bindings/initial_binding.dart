import 'package:book_store/controllers/admin_controller.dart';
import 'package:book_store/controllers/author_controller.dart';
import 'package:book_store/controllers/book_controller.dart';
import 'package:book_store/controllers/controller.dart';
import 'package:book_store/controllers/language_controller.dart';
import 'package:book_store/controllers/member_controller.dart';
import 'package:book_store/services/auth_service.dart';
import 'package:book_store/services/connectivity_service.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityService(), permanent: true);
    Get.put(LanguageController(), permanent: true);
    Get.put(AuthService(), permanent: true);
    Get.lazyPut(() => MemberController(), fenix: true);
    Get.lazyPut(() => BookController(), fenix: true);
    Get.lazyPut(() => Controller(), fenix: true);
    Get.lazyPut(() => AdminController(), fenix: true);
    Get.lazyPut(() => AuthorController(), fenix: true);
  }
}
