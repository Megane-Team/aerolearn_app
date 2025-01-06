import 'dart:convert';

import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/utils/session.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:aerolearn/variable/profile.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'action/notification_post.dart';
import 'constant/variable.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final Set<int> _scheduledNotificationIds = {};

  static init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static scheduleNotification(int userId,
      PelaksanaanPelatihan pelatihan) async {
    if (_scheduledNotificationIds.contains(pelatihan.id)) {
      return;
    }

    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      pelatihan.tanggalMulai.subtract(Duration(days: 3)),
      tz.local,
    );

    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      return;
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      '1',
      'scheduled_channel',
      channelDescription: 'Channel for scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      pelatihan.id,
      pelatihan.namaPelatihan,
      'pelatihan ${pelatihan
          .namaPelatihan} akan dilaksanakan 3 hari lagi, pada tanggal ${pelatihan
          .tanggalMulai}',
      scheduledDate,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: jsonEncode({
        'userId': userId,
        'pelatihanId': pelatihan.id,
        'title': pelatihan.namaPelatihan,
        'detail':
        'pelatihan ${pelatihan
            .namaPelatihan} akan dilaksanakan 3 hari lagi, pada tanggal ${pelatihan
            .tanggalMulai}',
        'tanggal': scheduledDate.toString(),
      }),
    );

    _scheduledNotificationIds.add(pelatihan.id);
    await addNotificationHistory(jsonEncode({
      'userId': userId,
      'pelatihanId': pelatihan.id,
      'title': pelatihan.namaPelatihan,
      'detail':
      'pelatihan ${pelatihan
          .namaPelatihan} akan dilaksanakan 3 hari lagi, pada tanggal ${pelatihan
          .tanggalMulai}',
      'tanggal': scheduledDate.toString(),
    }));
  }

  static Future<void> addNotificationHistory(String? payload) async {
    if (payload != null) {
      final data = jsonDecode(payload);
      final userId = data['userId'].toString();
      final pelatihanId = data['pelatihanId'].toString();
      final title = data['title'];
      final detail = data['detail'];
      final tanggal = data['tanggal'];

      await addNotification(
          int.parse(userId), title, detail, tanggal, int.parse(pelatihanId));
    }
  }

  static Future<UserProfile?> fetchUserProfile() async {
    try {
      final url = '$baseURL/user/profile';
      final response = await HttpService.getRequest(url);
      if (response.statusCode == 200) {
        return UserProfile.fromJson(json.decode(response.body)['data']);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      return null;
    }
  }

  static fetchAndScheduleNotifications() async {
    try {
      Future<List<PelaksanaanPelatihan>> fetchNotificationsTraining(
          String id) async {
        final url = '$baseURL/peserta/progress/$id';
        final response = await HttpService.getRequest(url);
        if (response.statusCode == 200) {
          Map<String, dynamic> jsonResponse = json.decode(response.body);
          List<dynamic> data = jsonResponse['data'];
          return data
              .map((item) => PelaksanaanPelatihan.fromJson(item))
              .toList();
        } else {
          throw Exception('Failed to load training data');
        }
      }

      var token = await SessionService.getToken();
      if (token != null && token.isNotEmpty) {
        UserProfile? userProfile = await fetchUserProfile();
        if (userProfile != null && userProfile.id != null) {
          String userId = userProfile.id.toString();
          List<PelaksanaanPelatihan> pelatihanList =
          await fetchNotificationsTraining(userId);
          for (var pelatihan in pelatihanList) {
            if (pelatihan.tanggalMulai.isAfter(DateTime.now())) {
              try {
                scheduleNotification(int.parse(userId), pelatihan);
              } catch (e) {
                // Handle the exception, e.g. log it
              }
            }
          }
        } else {
          throw Exception('User ID is null or empty');
        }
      }
    } catch (e) {
      throw ('Error fetching and scheduling notifications: $e');
    }
  }
}