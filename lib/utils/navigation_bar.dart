import 'package:aerolearn/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/page/beranda.dart';
import 'package:aerolearn/page/progress.dart';
import 'package:aerolearn/page/schedule.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    NotificationService.fetchAndScheduleNotifications();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        const Schedule();
        break;
      case 1:
        const Beranda();
        break;
      case 2:
        const Progress();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          Schedule(),
          Beranda(),
          Progress(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: SizedBox(
          height: 75,
          child: BottomNavigationBar(
            backgroundColor: Color(0xFFE4E4E4),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month,
                  color: _selectedIndex == 0
                      ? const Color(0xFF0463CA)
                      : const Color(0xFF74AEFF),
                ),
                label: 'Jadwal',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _selectedIndex == 1
                      ? const Color(0xFF0463CA)
                      : const Color(0xFF74AEFF),
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.show_chart,
                  color: _selectedIndex == 2
                      ? const Color(0xFF0463CA)
                      : const Color(0xFF74AEFF),
                ),
                label: 'Progres',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedFontSize: 14.0,
            unselectedFontSize: 12.0,
            selectedIconTheme: const IconThemeData(size: 35.0),
            unselectedIconTheme: const IconThemeData(size: 25.0),
          ),
        ),
      ),
    );
  }
}
