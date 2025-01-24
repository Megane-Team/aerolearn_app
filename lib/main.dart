// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:aerolearn/router.dart';
import 'package:aerolearn/constant/themes.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'notification_service.dart';
import 'package:workmanager/workmanager.dart';

Future<void> requestNotificationPermission() async {
  if (await Permission.notification.request().isGranted) {
    // Notification permission granted
  } else {
    // Notification permission denied
  }
}

void callbackDispatcher() {
  print('halo');
  Workmanager().executeTask((task, inputData) async {
    try {
      await NotificationService.fetchAndScheduleNotificationsInBackground();
    } catch (e) {}
    return Future.value(true);
  });
}

Future<void> requestExactAlarmPermission() async {
  if (await Permission.scheduleExactAlarm.request().isGranted) {
    // print('permission granted');
  } else {
    await Permission.scheduleExactAlarm.request();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode  : true);
  await Workmanager().registerPeriodicTask(
    'fetch_data_task', // ID tugas
    'fetch_data_api', // Nama worker
    frequency: Duration(minutes: 15), // Frekuensi
    initialDelay: Duration(seconds: 10), // Delay awal
  );
  await requestExactAlarmPermission();
  await requestNotificationPermission();
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
