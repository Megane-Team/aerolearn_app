import 'dart:async';

import 'package:aerolearn/action/jenis_training.dart';
import 'package:aerolearn/page/sub_page/detail.dart';
import 'package:aerolearn/page/sub_page/notification.dart';
import 'package:aerolearn/page/sub_page/profile.dart';
import 'package:aerolearn/variable/jenis_training.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/utils/greetings.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../action/notifications.dart';
import '../action/profile.dart';
import '../utils/notifications_icon.dart';
import '../variable/notifications.dart';
import '../variable/profile.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  TextEditingController searchController = TextEditingController();
  late Future<List<Training>?> futureTrainingData;
  late Future<List<Notifications>?> futureNotificationData;
  UserProfile? userProfile;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureTrainingData = fetchTrainingData(context);
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

  Future<void> _refreshTrainingData() async {
    setState(() {
      futureTrainingData = fetchTrainingData(context);
    });
  }

  List<Training> filterTraining(List<Training> training, String query) {
    if (query.isEmpty) {
      return training;
    } else {
      return training
          .where((t) => t.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(175.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
          child: AppBar(
            backgroundColor: const Color(0xFF12395D),
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 10, right: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: const CircleAvatar(
                      radius: 23,
                      backgroundColor: Color(0xffDADADA),
                      child: Icon(
                        Icons.person,
                        size: 29,
                        color: Color(0xff12395D),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hi, ',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Text(
                        getGreeting(),
                        style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationPage())
                      ).then((_) {
                      _refreshTrainingData();
                      });
                    },
                    child: FutureBuilder<List<Notifications>?>(
                  future: futureNotificationData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        List<Notifications> notifications = snapshot.data!;
                        DateTime now = DateTime.now();
                        notifications = notifications.where((notification) {
                          DateTime notificationDate = DateFormat('yyyy-MM-dd').parse(notification.tanggal.toString());
                          return notificationDate.isBefore(now) || notificationDate.isAtSameMomentAs(now);
                        }).toList();
                        return FutureBuilder<SharedPreferences>(
                          future: SharedPreferences.getInstance(),
                          builder: (context, prefsSnapshot) {
                            if (prefsSnapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (prefsSnapshot.hasError) {
                              return Center(child: Text('Error: ${prefsSnapshot.error}'));
                            } else if (prefsSnapshot.hasData) {
                              final prefs = prefsSnapshot.data!;
                              bool hasUnread = notifications.any((notification) {
                                return !(prefs.getBool('notification_${notification.id}') ?? false);
                              });
                              return NotificationIconWithDot(hasUnreadNotifications: hasUnread);
                            } else {
                              return const Icon(
                                Icons.notifications,
                                color: Colors.white,
                              );
                            }
                          },
                        );
                      } else {
                        return const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        );
                      }
                    },
                  ),
                  )
                ],
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color:
                    const Color(0xFF12395D), // Ensure the color is consistent
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 5),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: Color(0xff12395D)),
                        hintText: 'Cari Pelatihan',
                        hintStyle: TextStyle(
                          color: Color(0xff12395D),
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshTrainingData,
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<Training>?>(
                    future: futureTrainingData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        List<Training> trainingData =
                            filterTraining(snapshot.data!, searchQuery);
                        if (trainingData.isEmpty) {
                          return Center(child: Text('Tidak ada pelatihan'));
                        }
                        return ListView.builder(
                          itemCount: trainingData.length,
                          itemBuilder: (context, index) {
                            var detailTraining = trainingData[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 16, left: 16, bottom: 2),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 95,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEDEDED),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Pelatihan',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              detailTraining.nama,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          var id = detailTraining.id.toString();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Detail(id: id)));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF2C2C2C),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text('Rincian'),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('Koneksi eror'));
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  final bool hasUnreadNotifications;

  const NotificationIcon({Key? key, required this.hasUnreadNotifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      hasUnreadNotifications ? Icons.notifications_active : Icons.notifications,
      color: Colors.white,
    );
  }
}
