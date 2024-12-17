// ignore_for_file: non_constant_identifier_names

import 'package:aerolearn/action/absen.dart';
import 'package:aerolearn/action/absenPost.dart';
import 'package:aerolearn/action/materi.dart';
import 'package:aerolearn/utils/asset.dart';
import 'package:aerolearn/variable/materi.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/page/sub_page/materi_page.dart';
import 'package:quickalert/quickalert.dart';

class KatalogTraining extends StatefulWidget {
  final int id;
  final String instruktur;
  final String training;
  final String? id_pelatihan;
  const KatalogTraining(
      {super.key,
      required this.id,
      required this.instruktur,
      required this.training,
      required this.id_pelatihan});

  @override
  State<KatalogTraining> createState() => _KatalogTrainingState();
}

class _KatalogTrainingState extends State<KatalogTraining> {
  late Future<List<Materi>?> futureMateri;
  bool isLocked = false;

  @override
  void initState() {
    super.initState();
    futureMateri = fetchMateriData(context, widget.id_pelatihan);
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
            Expanded(
              child: Center(
                child: Text(
                  'Katalog Pelatihan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SizedBox(width: 48),
          ],
        ),
        backgroundColor: Color(0xff12395D),
      ),
      body: Column(
        children: [
          SizedBox(height: 14),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.92,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFEDEDED),
                border: Border(
                  top: BorderSide(color: Color(0xFF898989)),
                  left: BorderSide(color: Color(0xFF898989)),
                  right: BorderSide(color: Color(0xFF898989)),
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 22, left: 18),
                    child: Text(
                      widget.training,
                      style: TextStyle(
                          color: Color(0xFF1D5C96),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 18),
                    child: Text(
                      widget.instruktur,
                      style: TextStyle(
                          color: Color(0xFF1D5C96),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: 383,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF898989)),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: FutureBuilder<List<Materi>?>(
                            future: futureMateri,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                List<Materi> materiAll = snapshot.data ?? [];
                                return ListView.builder(
                                  itemCount: materiAll.length,
                                  itemBuilder: (context, index) {
                                    var materi = materiAll[index];
                                    return FutureBuilder<bool?>(
                                      future:
                                          fetchAbsenData(context, materi.id),
                                      builder: (context, attendanceSnapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        } else if (attendanceSnapshot.hasData &&
                                            attendanceSnapshot.data == true) {
                                          return buildTrainingButton(
                                              context,
                                              materi.judul,
                                              true,
                                              materi.konten,
                                              materi.id,
                                              widget.id);
                                        } else {
                                          return buildTrainingButton(
                                              context,
                                              materi.judul,
                                              false,
                                              materi.konten,
                                              materi.id,
                                              widget.id);
                                        }
                                      },
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                    child: Text('Data tidak tersedia'));
                              }
                            })),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget buildTrainingButton(BuildContext context, String title, bool isUnlocked,
    konten, idMateri, idPelaksanaanPelatihan) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: GestureDetector(
      onTap: isUnlocked
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MateriPage(konten: konten),
                ),
              );
            }
          : () {
              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  text: 'Absen',
                  confirmBtnText: 'Ya',
                  cancelBtnText: 'Tidak',
                  confirmBtnColor: Colors.green,
                  confirmBtnTextStyle:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                  onConfirmBtnTap: () async {
                    Navigator.of(context).pop();
                    var res = await absenPeserta(
                        context, idMateri, idPelaksanaanPelatihan);
                    if (res == "anda sudah absen") {
                      showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Informasi'),
                              content: Text('Anda sudah absen.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          });
                    }
                  });
            },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFF898989)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xFF1D5C96),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
