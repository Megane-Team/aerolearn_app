import 'dart:async';

import 'package:aerolearn/action/pelaksanaan.dart';
import 'package:aerolearn/page/sub_page/katalog_training.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:aerolearn/utils/formatted.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/variable/profile.dart';

import '../action/profile.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  late Future<List<PelaksanaanPelatihan>?> futurePelaksanaanPelatihanData;
  UserProfile? userProfile;
  Timer? _timer;

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
      });
    }
  }

  Future<void> _refreshPelaksanaanPelatihanData() async {
    setState(() {
      futurePelaksanaanPelatihanData =
          fetchPelaksanaanTraining(context, userProfile!.id);
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
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.only(
              top: 20.0,
              left: 15,
              bottom: 18,
            ), // Adjust the value as needed
            child: Text(
              'Progres Latihan',
              style: TextStyle(
                  fontWeight: FontWeight.w900, color: Color(0xff12395D)),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshPelaksanaanPelatihanData,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<PelaksanaanPelatihan>?>(
                    future: futurePelaksanaanPelatihanData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        List<PelaksanaanPelatihan> training = snapshot.data
                                ?.where((item) => item.isSelesai != 'selesai')
                                .toList() ??
                            [];
                        if (training.isEmpty) {
                          return Center(child: Text('Tidak ada progres'));
                        }
                        return ListView.builder(
                          itemCount: training.length,
                          itemBuilder: (context, index) {
                            var progressTraining = training[index];
                            DateTime startDate = DateTime.parse(
                                progressTraining.tanggalMulai.toString());
                            DateTime endDate = DateTime.parse(
                                progressTraining.tanggalSelesai.toString());
                            DateTime currentDate = DateTime.now();

                            String displayDate;
                            if (currentDate.isAfter(startDate) &&
                                currentDate.isBefore(endDate)) {
                              displayDate = 'Today';
                            } else {
                              displayDate = Formatted.formatDate(startDate);
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                right: 16,
                                left: 16,
                              ),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 190,
                                decoration: BoxDecoration(
                                  color: const Color(0xffEDEDED),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Pelatihan',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Flexible(
                                          child: Text(
                                            displayDate,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${Formatted.formatTime(progressTraining.jamMulai)} - ${Formatted.formatTime(progressTraining.jamSelesai)}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      progressTraining.namaPelatihan,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      progressTraining.ruangan,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            var id = progressTraining.id;
                                            var kategori =
                                                progressTraining.jenisTraining;
                                            var idPelatihan = progressTraining
                                                .idPelatihan
                                                .toString();
                                            String instruktur =
                                                progressTraining.namaInstruktur;
                                            String training =
                                                progressTraining.namaPelatihan;
                                            bool isSelesai = true;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        KatalogTraining(
                                                          id: id,
                                                          instruktur:
                                                              instruktur,
                                                          training: training,
                                                          idPelatihan:
                                                              idPelatihan,
                                                          isSelesai: isSelesai,
                                                          kategori: kategori,
                                                        )));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF2C2C2C),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Buka Katalog'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                progressTraining.namaInstruktur,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Text(
                                                'Instruktur',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('Connection error'));
                      }
                    }),
              )
            ],
          ),
        ));
  }
}
