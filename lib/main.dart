import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initNotification();
  }

  Future<void> _initNotification() async {
    // 1. Permission so‘rash (Android 13+ uchun)
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      final result = await Permission.notification.request();
      print("Notification permission result: $result");
      if (!result.isGranted) {
        print("❌ Ruxsat berilmadi, notification ishlamasligi mumkin");
        return;
      }
    } else {
      print("🔔 Notification permission oldin berilgan");
    }

    // 2. Notification pluginni ishga tushirish
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _local.initialize(settings);

    // 3. Notification ko‘rsatish
    const NotificationDetails platformDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "welcome_channel",
        "Welcome Notifications",
        channelDescription: "Book Store ilovasi uchun kanal",
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _local.show(
      0,
      "Xush kelibsiz!",
      "Book Store ilovasiga hush kelibsiz!",
      platformDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Notification Test")),
        body: const Center(child: Text("Notification bilan ishlash")),
      ),
    );
  }
}
