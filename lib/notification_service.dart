// ignore_for_file: depend_on_referenced_packages

import 'package:aerolearn/action/pelaksanaan.dart';
import 'package:aerolearn/utils/session.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledDate) async {
    final tz.TZDateTime tzScheduledDate =
        tz.TZDateTime.from(scheduledDate, tz.local);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzScheduledDate,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  void scheduleTrainingNotification(PelaksanaanPelatihan pelatihan) {
    DateTime target = DateTime.now().copyWith(hour: 19, minute: 29);
    DateTime scheduledDate = target.subtract(Duration(minutes: 5));
    scheduleNotification(
      pelatihan.id,
      'Reminder: ${pelatihan.nama_pelatihan}',
      'Pelatihan ${pelatihan.nama_pelatihan} akan dimulai pada ${pelatihan.tanggal}',
      scheduledDate,
    );
  }

  Future<void> fetchAndScheduleNotifications() async {
    try {
      var token = await SessionService.getToken();
      if (token != null && token.isNotEmpty) {
        List<PelaksanaanPelatihan> pelatihanList =
            await fetchPelaksanaanTraining();
        for (var pelatihan in pelatihanList) {
          scheduleTrainingNotification(pelatihan);
        }
      }
    } catch (e) {
      throw ('Error fetching and scheduling notifications: $e');
    }
  }
}
