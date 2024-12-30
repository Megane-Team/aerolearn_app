import 'dart:convert';

import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/utils/session.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static scheduleNotification(PelaksanaPelatihan pelatihan) async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      pelatihan.tanggal_mulai
          .subtract(Duration(days: 3))
          .add(Duration(hours: 10, minutes: 30)),
      tz.local,
    );
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      pelatihan.id,
      pelatihan.nama_pelatihan,
      pelatihan.nama_instruktur,
      scheduledDate,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    print('Notification scheduled successfully');
  }

  static fetchAndScheduleNotifications() async {
    try {
      // Future<List<PelaksanaPelatihan>> fetchNotificationsTraining() async {
      //   final url = '$baseURL/peserta/progress';
      //   final response = await HttpService.getRequest(url);
      //   if (response.statusCode == 200) {
      //     Map<String, dynamic> jsonResponse = json.decode(response.body);
      //     List<dynamic> data = jsonResponse['data'];
      //     return data.map((item) => PelaksanaPelatihan.fromJson(item)).toList();
      //   } else {
      //     throw Exception('Failed to load training data');
      //   }
      // }
      //
      // var token = await SessionService.getToken();
      // if (token != null && token.isNotEmpty) {
      //   List<PelaksanaPelatihan> pelatihanList =
      //       await fetchNotificationsTraining();
      //   for (var pelatihan in pelatihanList) {
      //     scheduleNotification(pelatihan);
      //   }
      // }
    } catch (e) {
      throw ('Error fetching and scheduling notifications: $e');
    }
  }
}
