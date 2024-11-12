import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';

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
                // Aksi ketika tombol kembali ditekan
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
            description:
                'Pelatihan Aircraft Painting akan diadakan pada tanggal 01 November 2024.',
          ),
          NotificationItem(
            date: '25 Nov 2024',
            description:
                'Pelatihan Aircraft Painting akan diadakan pada tanggal 02 Desember 2024.',
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

  const NotificationItem(
      {super.key, required this.date, required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(date),
      subtitle: Text(description),
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
