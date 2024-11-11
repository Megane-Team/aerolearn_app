import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_dash/flutter_dash.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
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
              child: TableCalendar(
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
                calendarStyle: const CalendarStyle(
                  defaultTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  weekendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  selectedTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  todayTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xff12395D),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Color(0xffD0CCCC),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          listTraining(context, _selectedDay, _focusedDay),
        ],
      ),
    );
  }
}

Widget listTraining(context, selectedDay, focusedDay) {
  return Expanded(
    child: ListView.builder(
      itemCount: training.length,
      itemBuilder: (context, index) {
        var trainingList = training.toList()[index];
        DateTime trainingDate = DateTime.parse(trainingList['tanggal']!);
        if ((selectedDay != null && isSameDay(trainingDate, selectedDay!)) ||
            isSameDay(trainingDate, focusedDay!)) {
          return Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
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
                              trainingList['jam_mulai']!,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Dash(
                              direction: Axis.vertical,
                              length: 50,
                              dashLength: 5,
                              dashColor: Colors.black,
                            ),
                            Text(
                              trainingList['jam_selesai']!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        width: MediaQuery.of(context).size.width * 0.7,
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
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              trainingList['jenis_latihan']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              trainingList['kelas']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]));
        }
        return Container();
      },
    ),
  );
}

List<Map<String, String>> training = [
  {
    'jenis_latihan': 'Aircraft Painting',
    'kelas': 'Teori L.47',
    'jam_mulai': '08.00',
    'jam_selesai': '12.00',
    'tanggal': '2024-11-08'
  },
  {
    'jenis_latihan': 'Aircraft Modification',
    'kelas': 'Teori K.29',
    'jam_mulai': '12.00',
    'jam_selesai': '15.00',
    'tanggal': '2024-11-09',
  },
];
