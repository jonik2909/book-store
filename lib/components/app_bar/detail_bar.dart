import 'package:book_store/controllers/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// implements PreferredSizeWidget - Flutter'ga "Bu widget AppBar sifatida ishlatilishi mumkin" deb bildiradi
// preferredSize - Flutter'ga "Bu widget qancha joy egallaydi" deb bildiradi

// Oddiy qilib aytganda:

// implements = "Men AppBar bo'la olaman"
// preferredSize = "Mening balandligim shuncha"

// Bu ikkisiz sizning CustomAppBar Flutter'da ishlamaydi va compile vaqtida xatolik beradi.

class DetailBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function() onPressed;

  DetailBar({super.key, required this.onPressed});

  final LanguageController languageController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.share,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
