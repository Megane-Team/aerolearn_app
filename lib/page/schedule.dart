import 'dart:async';

import 'package:aerolearn/action/pelaksanaan.dart';
import 'package:aerolearn/utils/formatted.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../action/profile.dart';
import '../variable/profile.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Future<List<PelaksanaPelatihan>?> futurePelaksanaanPelatihanData;
  Timer? _timer;
  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    futurePelaksanaanPelatihanData = Future.value(null);
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    userProfile = await fetchUserProfile(context);
    if (userProfile != null) {
      setState(() {
        futurePelaksanaanPelatihanData =
            fetchPelaksanaanTraining(context, userProfile!.id);
        _startAutoRefresh();
      });
    }
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        futurePelaksanaanPelatihanData =
            fetchPelaksanaanTraining(context, userProfile!.id);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(
            top: 20.0,
            left: 15,
          ), // Adjust the value as needed
          child: Text(
            'Jadwal Pelatihan',
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Color(0xff12395D)),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(15),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: FutureBuilder<List<PelaksanaPelatihan>?>(
                future: futurePelaksanaanPelatihanData,
                builder: (context, snapshot) {
                  List<PelaksanaPelatihan> pelatihanList = [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    pelatihanList = snapshot.data!;
                  }

                  final filteredPelatihanList = pelatihanList.toList();

                  return TableCalendar(
                    firstDay: DateTime.utc(2000, 1, 1),
                    lastDay: DateTime.utc(2100, 12, 31),
                    focusedDay: _focusedDay,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                    ),
                    calendarFormat: CalendarFormat.month,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    eventLoader: (day) {
                      return filteredPelatihanList.where((pelatihan) {
                        DateTime startDate = pelatihan.tanggal_mulai;
                        DateTime endDate = pelatihan.tanggal_selesai;
                        return (day.isAfter(DateTime.now()) ||
                                isSameDay(day, DateTime.now())) &&
                            (isSameDay(day, startDate) ||
                                isSameDay(day, endDate) ||
                                (day.isAfter(startDate) &&
                                    day.isBefore(endDate)));
                      }).toList();
                    },
                    calendarStyle: const CalendarStyle(
                      defaultTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      weekendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      selectedTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      todayTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Color(0xff12395D),
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Color(0xffD0CCCC),
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          listTraining(context, _selectedDay, _focusedDay,
              futurePelaksanaanPelatihanData),
        ],
      ),
    );
  }
}

Widget listTraining(context, selectedDay, focusedDay, futurePelaksanaan) {
  return Expanded(
    child: FutureBuilder<List<PelaksanaPelatihan>?>(
        future: futurePelaksanaan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<PelaksanaPelatihan>? progress = snapshot.data;
            List<PelaksanaPelatihan> filteredList =
                progress!.where((trainingList) {
              DateTime now = DateTime.now();
              if (selectedDay != null) {
                if ((isSameDay(selectedDay, trainingList.tanggal_mulai) ||
                        isSameDay(selectedDay, trainingList.tanggal_selesai) ||
                        (selectedDay.isAfter(trainingList.tanggal_mulai) &&
                            selectedDay
                                .isBefore(trainingList.tanggal_selesai))) &&
                    (selectedDay.isAfter(now) || isSameDay(selectedDay, now))) {
                  return true;
                }
              }
              if (focusedDay != null) {
                if ((isSameDay(focusedDay, trainingList.tanggal_mulai) ||
                        isSameDay(focusedDay, trainingList.tanggal_selesai) ||
                        (focusedDay.isAfter(trainingList.tanggal_mulai) &&
                            focusedDay
                                .isBefore(trainingList.tanggal_selesai))) &&
                    (focusedDay.isAfter(now) || isSameDay(focusedDay, now))) {
                  return true;
                }
              }
              return false;
            }).toList();

            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                var trainingList = filteredList[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 110,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Formatted.formatTime(trainingList.jam_mulai),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Dash(
                                  direction: Axis.vertical,
                                  length: 50,
                                  dashLength: 5,
                                  dashColor: Colors.black,
                                ),
                                Text(
                                  Formatted.formatTime(
                                      trainingList.jam_selesai),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            width: MediaQuery.of(context).size.width * 0.68,
                            height: 110,
                            decoration: BoxDecoration(
                              color: const Color(0xffEDEDED),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Training',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  trainingList.nama_pelatihan,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  trainingList.ruangan,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                );
              },
            );
          } else {
            return Text('Connection error');
          }
        }),
  );
}
