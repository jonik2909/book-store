import 'package:book_store/controllers/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// implements PreferredSizeWidget - Flutter'ga "Bu widget AppBar sifatida ishlatilishi mumkin" deb bildiradi
// preferredSize - Flutter'ga "Bu widget qancha joy egallaydi" deb bildiradi

// Oddiy qilib aytganda:

// implements = "Men AppBar bo'la olaman"
// preferredSize = "Mening balandligim shuncha"

// Bu ikkisiz sizning CustomAppBar Flutter'da ishlamaydi va compile vaqtida xatolik beradi.

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String desc;

  CustomAppBar({super.key, required this.title, required this.desc});

  final LanguageController languageController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.red,
              fontSize: 24,
            ),
          ),
          Text(
            desc,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                languageController.getCurrentLanguageFlag(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 2),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
          onPressed: () => languageController.showLanguageDialog(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
