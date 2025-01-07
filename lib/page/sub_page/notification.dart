import 'package:aerolearn/action/notifications.dart';
import 'package:aerolearn/utils/formatted.dart';
import 'package:aerolearn/variable/notifications.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../action/profile.dart';
import '../../variable/profile.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => NotificationState();
}

class NotificationState extends State<NotificationPage> {
  late Future<List<Notifications>?> futureNotificationData;
  UserProfile? userProfile;
  @override
  void initState() {
    super.initState();
    futureNotificationData = Future.value(null);
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    userProfile = await fetchUserProfile(context);
    if (userProfile != null) {
      setState(() {
        futureNotificationData = fetchNotifications(context, userProfile!.id);
      });
    }
  }

  Future<void> markAsRead(int notificationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_$notificationId', true);
  }

  Future<bool> isRead(int notificationId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notification_$notificationId') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset(Assets.icons('arrow_back')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Notifikasi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
        backgroundColor: const Color(0xff12395D),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 1),
        top: false,
        child: FutureBuilder<List<Notifications>?>(
          future: futureNotificationData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              if (snapshot.error.toString() == 'notifikasi tidak ada') {
                return Center(child: NoNotificationItem());
              } else {
                return Center(child: Text(snapshot.error.toString()));
              }
            } else if (snapshot.hasData) {
              List<Notifications> notifications = snapshot.data!;
              DateTime now = DateTime.now();
              notifications = notifications.where((notification) {
                DateTime notificationDate = DateFormat('yyyy-MM-dd')
                    .parse(notification.tanggal.toString());
                return notificationDate.isBefore(now) ||
                    notificationDate.isAtSameMomentAs(now);
              }).toList();
              if (notifications.isEmpty) {
                return Center(child: NoNotificationItem());
              }
              return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  var notification = notifications[index];
                  return FutureBuilder<bool>(
                    future: isRead(notification.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        bool isRead = snapshot.data ?? false;
                        return NotificationItem(
                          date: notification.tanggal,
                          title: notification.title,
                          detail: notification.detail,
                          isRead: isRead,
                          onTap: () async {
                            await markAsRead(notification.id);
                            setState(() {});
                          },
                        );
                      }
                    },
                  );
                },
              );
            } else {
              return Center(child: Text('gagal koneksi ke server'));
            }
          },
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final DateTime date;
  final String title;
  final String detail;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.date,
    required this.title,
    required this.detail,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isRead ? Colors.white : Colors.grey[300],
          border: Border(bottom: BorderSide(color: Colors.black, width: 1.0)),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 1),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 35),
            child: Icon(Icons.info_outline),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'info',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                Formatted.formatDate(date),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: 300,
                child: Text(
                  detail,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoNotificationItem extends StatelessWidget {
  const NoNotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              Assets.icons('mail_box'),
            ),
            const Text(
              'Tidak ada notifikasi',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
