// pages/no_internet_page.dart
import 'package:book_store/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetPage extends StatelessWidget {
  NoInternetPage({super.key});

  final ConnectivityService connectivityService =
      Get.put(ConnectivityService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please check your internet connection',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Internet holatini qayta tekshirish
                connectivityService.checkInitialConnection();
              },
              child: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
