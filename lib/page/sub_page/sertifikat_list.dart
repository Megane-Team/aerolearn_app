import 'package:aerolearn/action/pelaksanaan.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';

class SertifikatList extends StatefulWidget {
  const SertifikatList({super.key});

  @override
  State<SertifikatList> createState() => _SertifikatListState();
}

class _SertifikatListState extends State<SertifikatList> {
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
                      List<PelaksanaanPelatihan> sertifikat = snapshot.data
                          ?.where((item) => item.isSelesai != 'Selesai')
                          .toList() ??
                          [];
                      if (sertifikat.isEmpty) {
                        return Center(child: Text('No progress'));
                      }
                      return ListView.builder(
                        itemCount: sertifikat.length,
                        itemBuilder: (context, index) {
                          var verifikasi = sertifikat[index];
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
                                  ),
                                  Text(
                                    verifikasi.nama_pelatihan,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    verifikasi.ruangan,
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
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     var id = verifikasi.id;
                                      //     var idPelatihan = verifikasi
                                      //         .id_pelatihan
                                      //         .toString();
                                      //     String instruktur =
                                      //         verifikasi.nama_instruktur;
                                      //     String training =
                                      //         verifikasi.nama_pelatihan;
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 SertifikatKatalog(
                                      //                     id: id,
                                      //                     instruktur:
                                      //                     instruktur,
                                      //                     training: training,
                                      //                     id_pelatihan:
                                      //                     idPelatihan)));
                                      //   },
                                      //   style: ElevatedButton.styleFrom(
                                      //     backgroundColor: Colors.black,
                                      //     foregroundColor: Colors.white,
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius:
                                      //       BorderRadius.circular(8),
                                      //     ),
                                      //   ),
                                      //   child: const Text('Buka Katalog'),
                                      // ),
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
                                              verifikasi.nama_instruktur,
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
