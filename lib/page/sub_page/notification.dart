import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';
import 'package:go_router/go_router.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => NotificationState();
}

class NotificationState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset(Assets.icons('arrow_back')),
              onPressed: () {
                context.go('/mainpage');
              },
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Riwayat Pelatihan',
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
      body: ListView(
        children: const [
          NotificationItem(
            date: '25 Okt 2024',
            description: 'Pelatihan Aircraft Painting ',
            description1: 'akan diadakan pada tanggal 01 November 2024.',
          ),
          NoNotificationItem(),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String date;
  final String description;
  final String description1;

  const NotificationItem(
      {super.key,
      required this.date,
      required this.description,
      required this.description1});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
                width: 1.0
          )
        )
      ),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 1),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: Icon(Icons.info_outline),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'info',
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(width: 230),
                  Text(
                    date,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                description1,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          )),
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

List<Map<String, String>> training = [
  {
    'tanggal': '2024-11-08',
  },
  {
    'tanggal': '2024-11-09',
  },
];
