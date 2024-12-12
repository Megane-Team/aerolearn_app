import 'package:aerolearn/action/pelaksanaan.dart';
import 'package:aerolearn/page/sub_page/katalog_training.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:aerolearn/utils/formatted_date.dart';
import 'package:flutter/material.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  late Future<List<PelaksanaanPelatihan>> futurePelaksanaanPelatihanData;

  @override
  void initState() {
    super.initState();
    futurePelaksanaanPelatihanData = fetchPelaksanaanTraining();
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
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<PelaksanaanPelatihan>>(
                  future: futurePelaksanaanPelatihanData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<PelaksanaanPelatihan> training = snapshot.data
                              ?.where((item) => item.isSelesai != 'Selesai')
                              .toList() ??
                          [];
                      if (training.isEmpty) {
                        return Center(child: Text('No progress'));
                      }
                      return ListView.builder(
                        itemCount: training.length,
                        itemBuilder: (context, index) {
                          var progressTraining = training[index];
                          DateTime trainingDate = DateTime.parse(
                              progressTraining.tanggal.toString());
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        FormattedDate.formatDate(trainingDate),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${progressTraining.jam_mulai} - ${progressTraining.jam_selesai}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    progressTraining.nama_pelatihan,
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
                                          var idPelatihan = progressTraining
                                              .id_pelatihan
                                              .toString();
                                          String instruktur =
                                              progressTraining.nama_intsruktur;
                                          String training =
                                              progressTraining.nama_pelatihan;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      KatalogTraining(
                                                          id: id,
                                                          instruktur:
                                                              instruktur,
                                                          training: training,
                                                          id_pelatihan:
                                                              idPelatihan)));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              progressTraining.nama_intsruktur,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
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
                      return Center(child: Text('No data available'));
                    }
                  }),
            )
          ],
        ));
  }
}
