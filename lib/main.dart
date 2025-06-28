// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:book_store/controllers/language_controller.dart';
import 'package:book_store/pages/error/no_internet_page.dart';
import 'package:book_store/pages/main_page.dart';
import 'package:book_store/services/connectivity_service.dart';
import 'package:book_store/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  Get.put(ConnectivityService());
  // Flutter platformasi to'liq ishga tushishini kafolatlash uchun kerak,
  // ayniqsa async kodlar (await) oldidan chaqiriladi.
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await GetStorage.init();

  Get.put(LanguageController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final LanguageController languageController = Get.put(LanguageController());
  final ConnectivityService connectivityService =
      Get.put(ConnectivityService());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // ✅ ASOSIY TUZATISH: locale parametrini qo'shish
      locale: languageController.currentLocale.value,

      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('uz'),
      ],

      home: Obx(() {
        if (connectivityService.isConnected.value) {
          return MainPage();
        } else {
          return NoInternetPage();
        }
      }),
    );
  }
}
