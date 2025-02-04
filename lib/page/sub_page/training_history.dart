import 'package:aerolearn/action/pelaksanaan.dart';
import 'package:aerolearn/page/sub_page/katalog_training.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/utils/formatted.dart';
import 'package:aerolearn/utils/asset.dart';

class History extends StatefulWidget {
  final String? id;
  const History({super.key, required this.id});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<List<PelaksanaanPelatihan>?>
      futurePelaksanaanPelatihanSelesaiData;

  @override
  void initState() {
    super.initState();
    futurePelaksanaanPelatihanSelesaiData =
        fetchPelaksanaanTraining(context, widget.id);
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
                child: FutureBuilder<List<PelaksanaanPelatihan>?>(
                    future: futurePelaksanaanPelatihanSelesaiData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        if (snapshot.error == 'tidak ada pelatihan') {
                          return Center(
                            child: Text('tidak ada pelatihan yang selesai'),
                          );
                        } else {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    snapshot.error.toString(),
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      } else if (snapshot.hasData) {
                        List<PelaksanaanPelatihan> training = snapshot.data
                                ?.where((item) => item.isSelesai == 'selesai')
                                .toList() ??
                            [];
                        if (training.isEmpty) {
                          return Center(
                              child: Text('Tidak ada pelatihan yang selesai'));
                        }
                        return ListView.builder(
                          itemCount: training.length,
                          itemBuilder: (context, index) {
                            var trainingSelesai = training[index];
                            DateTime endDate = DateTime.parse(
                                trainingSelesai.tanggalSelesai.toString());
                            String displayDate = Formatted.formatDate(endDate);
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
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
                                          displayDate,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      trainingSelesai.namaPelatihan,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      trainingSelesai.ruangan,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            var id = trainingSelesai.id;
                                            var kategori =
                                                trainingSelesai.jenisTraining;
                                            var idPelatihan = trainingSelesai
                                                .idPelatihan
                                                .toString();
                                            String instruktur =
                                                trainingSelesai.namaInstruktur;
                                            String training =
                                                trainingSelesai.namaPelatihan;
                                            bool isProgress = false;
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
                                                          isProgress:
                                                              isProgress,
                                                          kategori: kategori,
                                                        )));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff14AE5C),
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              trainingSelesai.namaInstruktur,
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
                        );
                      } else {
                        return Center(
                          child: Text('gagal koneksi ke server'),
                        );
                      }
                    }))
          ],
        ));
  }
}
