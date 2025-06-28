// lib/controllers/language_controller.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  static LanguageController get to => Get.find();

  final _storage = GetStorage();
  final _storageKey = 'selected_language';

  // Mavjud tillar
  final List<Map<String, dynamic>> languages = [
    {
      'nativeName': 'English',
      'locale': const Locale('en'),
      'code': 'en',
      'flag': '🇺🇸'
    },
    {
      'nativeName': 'O\'zbek tili',
      'locale': const Locale('uz'),
      'code': 'uz',
      'flag': '🇺🇿'
    },
  ];

  // Joriy til
  Rx<Locale> currentLocale = const Locale('en').obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  // Saqlangan tilni yuklash
  void _loadSavedLanguage() {
    final savedLanguage = _storage.read(_storageKey);
    if (savedLanguage != null) {
      final locale = Locale(savedLanguage);
      currentLocale.value = locale;
    }
  }

  // Tilni o'zgartirish
  void changeLanguage(String languageCode) {
    final locale = Locale(languageCode);
    currentLocale.value = locale;

    // ✅ MUHIM: GetX'ga til o'zgarganini bildirish
    Get.updateLocale(locale);

    _storage.write(_storageKey, languageCode);

    // ✅ Dialog'ni yopish
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  // Joriy til bayrog'ini olish
  String getCurrentLanguageFlag() {
    final currentLang = languages.firstWhere(
      (lang) => lang['code'] == currentLocale.value.languageCode,
      orElse: () => languages.first,
    );
    return currentLang['flag'];
  }

  // ✅ YAXSHILANGAN: Til tanlash dialog
  void showLanguageDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dialog title
              const Text(
                'Select Language', // Bu ham ARB faylga qo'shilishi mumkin
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Tillar ro'yxati
              ...languages.map((language) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        changeLanguage(language['code']);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: currentLocale.value.languageCode ==
                                  language['code']
                              ? Border.all(color: Colors.blue, width: 2)
                              : Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Text(
                              language['flag'],
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    language['nativeName'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (currentLocale.value.languageCode ==
                                language['code'])
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Bekor qilish tugmasi
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back(); // ✅ Manual yopish
                  },
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true, // ✅ Tashqariga bosib yopish mumkin
    );
  }
}
