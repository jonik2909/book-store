import 'package:book_store/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // Flutter platformasi to‘liq ishga tushishini kafolatlash uchun kerak,
  // ayniqsa async kodlar (await) oldidan chaqiriladi.
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(), // ✅ context kerak emas
      ),
      home: MainPage(),
    );
  }
}
