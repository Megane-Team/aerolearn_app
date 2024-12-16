import 'package:flutter/material.dart';
import 'package:aerolearn/utils/formatted_date.dart';
import 'package:aerolearn/utils/asset.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
                  Navigator.pop(context);
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
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: training.length,
                itemBuilder: (context, index) {
                  var progressTraining = training[index];
                  DateTime trainingDate =
                      DateTime.parse(progressTraining['tanggal']!);
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 170,
                      decoration: BoxDecoration(
                        color: const Color(0xffEDEDED),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Pelatihan',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                FormattedDate.formatDate(trainingDate),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            progressTraining['jenis_latihan']!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                          Text(
                            progressTraining['kelas']!,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Add your onPressed code here!
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff14AE5C),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Buka Katalog'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    progressTraining['instruktur']!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'Instruktur',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}

List<Map<String, String>> training = [
  {
    'jenis_latihan': 'Aircraft Painting',
    'kelas': 'Teori L.47',
    'jam_mulai': '08.00',
    'jam_selesai': '12.00',
    'tanggal': '2024-11-08',
    'instruktur': 'Muhammad Hafidz',
  },
  {
    'jenis_latihan': 'Aircraft Modification',
    'kelas': 'Teori K.29',
    'jam_mulai': '12.00',
    'jam_selesai': '15.00',
    'tanggal': '2024-11-09',
    'instruktur': 'Muhammad Yusuf',
  },
  {
    'jenis_latihan': 'Aircraft Painting',
    'kelas': 'Teori L.47',
    'jam_mulai': '08.00',
    'jam_selesai': '12.00',
    'tanggal': '2024-11-08',
    'instruktur': 'Muhammad Hafidz',
  },
  {
    'jenis_latihan': 'Aircraft Modification',
    'kelas': 'Teori K.29',
    'jam_mulai': '12.00',
    'jam_selesai': '15.00',
    'tanggal': '2024-11-09',
    'instruktur': 'Muhammad Yusuf',
  },
  {
    'jenis_latihan': 'Aircraft Painting',
    'kelas': 'Teori L.47',
    'jam_mulai': '08.00',
    'jam_selesai': '12.00',
    'tanggal': '2024-11-08',
    'instruktur': 'Muhammad Hafidz',
  },
  {
    'jenis_latihan': 'Aircraft Modification',
    'kelas': 'Teori K.29',
    'jam_mulai': '12.00',
    'jam_selesai': '15.00',
    'tanggal': '2024-11-09',
    'instruktur': 'Muhammad Yusuf',
  },
  {
    'jenis_latihan': 'Aircraft Painting',
    'kelas': 'Teori L.47',
    'jam_mulai': '08.00',
    'jam_selesai': '12.00',
    'tanggal': '2024-11-08',
    'instruktur': 'Muhammad Hafidz',
  },
  {
    'jenis_latihan': 'Aircraft Modification',
    'kelas': 'Teori K.29',
    'jam_mulai': '12.00',
    'jam_selesai': '15.00',
    'tanggal': '2024-11-09',
    'instruktur': 'Muhammad Yusuf',
  },
];
