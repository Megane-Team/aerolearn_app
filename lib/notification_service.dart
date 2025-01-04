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
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final Set<int> _scheduledNotificationIds = {};

  static init() async {
    print('Initializing NotificationService');
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    print('NotificationService initialized');
  }

  static scheduleNotification(int userId, PelaksanaPelatihan pelatihan) async {
    if (_scheduledNotificationIds.contains(pelatihan.id)) {
      print('Notification already scheduled for id: ${pelatihan.id}');
      return;
    }

    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      pelatihan.tanggal_mulai
          .subtract(Duration(days: 2))
          .add(Duration(hours: 16, minutes: 39)),
      tz.local,
    );

    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      print('Scheduled date must be in the future: ${scheduledDate.toString()}');
      return;
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1',
      'scheduled_channel',
      channelDescription: 'Channel for scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      pelatihan.id,
      pelatihan.nama_pelatihan,
      pelatihan.nama_instruktur,
      scheduledDate,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: jsonEncode({
        'userId': userId,
        'pelatihanId': pelatihan.id,
        'title': pelatihan.nama_pelatihan,
        'detail': pelatihan.nama_instruktur,
        'tanggal': scheduledDate.toString(),
      }),
    );

    _scheduledNotificationIds.add(pelatihan.id);
    await addNotificationHistory(jsonEncode({
      'userId': userId,
      'pelatihanId': pelatihan.id,
      'title': pelatihan.nama_pelatihan,
      'detail': pelatihan.nama_instruktur,
      'tanggal': scheduledDate.toString(),
    }));
    print('Notification scheduled for id: ${pelatihan.id}');
  }

  static Future<void> addNotificationHistory(String? payload) async {
    if (payload != null) {
      print('Processing notification payload: $payload');
      final data = jsonDecode(payload);
      final userId = data['userId'].toString();
      final pelatihanId = data['pelatihanId'].toString();
      final title = data['title'];
      final detail = data['detail'];
      final tanggal = data['tanggal'];

      print('Sending post request with userId: $userId, title: $title, detail: $detail, tanggal: $tanggal, pelatihanId: $pelatihanId');
      String? response = await addNotification(int.parse(userId), title, detail, tanggal, int.parse(pelatihanId));
      if (response != 'notification berhasil dibuat') {
        print('Notification already created or failed to create: $response');
      } else {
        print('Notification created successfully');
      }
    } else {
      print('No payload received');
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
      print('Error fetching user profile: $e');
      return null;
    }
  }

  static fetchAndScheduleNotifications() async {
    try {
      Future<List<PelaksanaPelatihan>> fetchNotificationsTraining(String id) async {
        final url = '$baseURL/peserta/progress/$id';
        final response = await HttpService.getRequest(url);
        if (response.statusCode == 200) {
          Map<String, dynamic> jsonResponse = json.decode(response.body);
          List<dynamic> data = jsonResponse['data'];
          return data.map((item) => PelaksanaPelatihan.fromJson(item)).toList();
        } else {
          throw Exception('Failed to load training data');
        }
      }

      var token = await SessionService.getToken();
      if (token != null && token.isNotEmpty) {
        UserProfile? userProfile = await fetchUserProfile();
        if (userProfile != null && userProfile.id != null) {
          int userId = userProfile.id;
          List<PelaksanaPelatihan> pelatihanList = await fetchNotificationsTraining(userId.toString());
          for (var pelatihan in pelatihanList) {
            if (pelatihan.tanggal_mulai.isAfter(DateTime.now())) {
              try {
                scheduleNotification(userId, pelatihan);
              } catch (e) {
                print('Error scheduling notification: $e');
              }
            } else {
              print('Skipping past event: ${pelatihan.nama_pelatihan}');
            }
          }
        } else {
          throw Exception('User ID is null or empty');
        }
      }
    } catch (e) {
      print('Error fetching and scheduling notifications: $e');
      throw ('Error fetching and scheduling notifications: $e');
    }
  }
}