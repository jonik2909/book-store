import 'package:book_store/controller/member.controller.dart';
import 'package:book_store/pages/home_page.dart';
import 'package:book_store/pages/main_page.dart';
import 'package:book_store/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MemberController memberController = Get.put(MemberController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Obx(() =>
          memberController.isAuthenticated.value ? MainPage() : SplashPage()),
    );
  }
}
