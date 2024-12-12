// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:aerolearn/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/router.dart';
import 'package:aerolearn/constant/themes.dart';
import 'package:go_router/src/router.dart';
import 'notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final NotificationService notificationService = NotificationService();
var token = SessionService.getToken();

var checkToken = () async {
  final tokenValue = await token;
  if (tokenValue != null && tokenValue.isNotEmpty) {
    await notificationService.fetchAndScheduleNotifications();
  }
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await notificationService.init();
  await checkToken;
  final router = await AppRouter.createRouter();
  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      routerConfig: router,
    );
  }
}
