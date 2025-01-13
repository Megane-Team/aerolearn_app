import 'package:aerolearn/action/absen_exam.dart';
import 'package:aerolearn/action/absen_materi.dart';
import 'package:aerolearn/action/absen_post.dart';
import 'package:aerolearn/action/alat.dart';
import 'package:aerolearn/action/exam.dart';
import 'package:aerolearn/action/materi.dart';
import 'package:aerolearn/action/nilai.dart';
import 'package:aerolearn/page/sub_page/feedback.dart';
import 'package:aerolearn/page/sub_page/ujian_page.dart';
import 'package:aerolearn/utils/asset.dart';
import 'package:aerolearn/variable/alat.dart';
import 'package:aerolearn/variable/exam.dart';
import 'package:aerolearn/variable/materi.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/page/sub_page/materi_page.dart';
import 'package:quickalert/quickalert.dart';

import '../../action/profile.dart';
import '../../variable/nilai.dart';
import '../../variable/profile.dart';

class KatalogTraining extends StatefulWidget {
  final int id;
  final String instruktur;
  final String training;
  final String? idPelatihan;
  final bool isProgress;
  final String kategori;

  const KatalogTraining(
      {super.key,
      required this.id,
      required this.instruktur,
      required this.training,
      required this.idPelatihan,
      required this.isProgress,
      required this.kategori});

  @override
  State<KatalogTraining> createState() => _KatalogTrainingState();
}

class _KatalogTrainingState extends State<KatalogTraining> {
  late Future<List<Materi>?> futureMateri;
  late Future<List<Exam>?> futureExam;
  late Future<Nilai?> futureNilai;
  late Future<List<Alat>?> futureAlat;
  UserProfile? userProfile;
  bool isLocked = false;
  bool nilai = false;
  @override
  void initState() {
    super.initState();
    futureMateri = fetchMateriData(context, widget.idPelatihan);
    futureExam = fetchExamData(context, widget.idPelatihan);
    futureAlat = fetchAlat(context, widget.id);
    _fetchUserProfile();
    futureNilai = Future.value(null);
  }

  void _fetchUserProfile() async {
    userProfile = await fetchUserProfile(context);
    if (userProfile != null) {
      setState(() {
        futureNilai = fetchNilai(context, userProfile!.id, widget.id);
      });
    }
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
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              futureMateri = fetchMateriData(context, widget.idPelatihan);
              futureExam = fetchExamData(context, widget.idPelatihan);
              futureAlat = fetchAlat(context, widget.id);
              _fetchUserProfile();
            });
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 22, left: 18),
                              child: Text(
                                widget.training,
                                style: TextStyle(
                                  color: Color(0xFF1D5C96),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2, // Added letter spacing
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 18),
                              child: Text(
                                widget.instruktur,
                                style: TextStyle(
                                  color: Color(0xFF1D5C96),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.1, // Added letter spacing
                                ),
                              ),
                            ),
                          ],
                        ),
                        FutureBuilder<Nilai?>(
                            future: futureNilai,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Container();
                              } else if (snapshot.hasData) {
                                nilai = true;
                                var nilaiData = snapshot.data;
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 40),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        nilaiData!.score.toString().length > 4
                                            ? nilaiData.score
                                                .toString()
                                                .substring(0, 4)
                                            : nilaiData.score.toString(),
                                        style: TextStyle(
                                          color: Color(0xFF1D5C96),
                                          fontSize: 36, // Increased font size
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 10.0,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              offset: Offset(2.0, 2.0),
                                            ),
                                          ], // Added shadow for a stylish effect
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            })
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.92,
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
                              child: Column(
                                children: [
                                  widget.kategori != "mandatory"
                                      ? FutureBuilder<List<Materi>?>(
                                          future: futureMateri,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (snapshot.hasError) {
                                              if (snapshot.error ==
                                                  "materi tidak ada") {
                                                return Center(
                                                    child: Text(
                                                        'tidak ada materi'));
                                              } else {
                                                return Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.error_outline,
                                                          color: Colors.red,
                                                          size: 30.0,
                                                        ),
                                                        SizedBox(height: 16.0),
                                                        Text(
                                                          snapshot.error
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            } else if (snapshot.hasData) {
                                              List<Materi> materiAll =
                                                  snapshot.data ?? [];
                                              if (materiAll.isEmpty) {
                                                return Center(
                                                    child: Text(
                                                        'Tidak ada materi'));
                                              }
                                              return Column(
                                                children: [
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: materiAll.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var materi =
                                                          materiAll[index];
                                                      return FutureBuilder<
                                                          bool?>(
                                                        future:
                                                            fetchAbsenDataMateri(
                                                                context,
                                                                materi.id,
                                                                widget.id),
                                                        builder: (context,
                                                            attendanceSnapshot) {
                                                          if (attendanceSnapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          } else if (attendanceSnapshot
                                                              .hasError) {
                                                            return Container();
                                                          } else if (attendanceSnapshot
                                                                  .hasData &&
                                                              attendanceSnapshot
                                                                      .data ==
                                                                  true) {
                                                            return buildTrainingButton(
                                                              context,
                                                              materi.judul,
                                                              true,
                                                              materi.konten,
                                                              materi.id,
                                                              widget.id,
                                                            );
                                                          } else {
                                                            return buildTrainingButton(
                                                              context,
                                                              materi.judul,
                                                              false,
                                                              materi.konten,
                                                              materi.id,
                                                              widget.id,
                                                            );
                                                          }
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  widget.isProgress
                                                      ? FutureBuilder<bool>(
                                                          future:
                                                              checkAllAttendanceMateri(
                                                                  materiAll,
                                                                  context,
                                                                  widget.id),
                                                          builder: (context,
                                                              snapshot) {
                                                            bool
                                                                allMaterialsAttended =
                                                                snapshot.hasData &&
                                                                    snapshot.data ==
                                                                        true;
                                                            return FutureBuilder<
                                                                List<Exam>?>(
                                                              future:
                                                                  futureExam,
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return Center(
                                                                      child:
                                                                          CircularProgressIndicator());
                                                                } else if (snapshot
                                                                    .hasError) {
                                                                  return Container();
                                                                } else if (snapshot
                                                                    .hasData) {
                                                                  List<Exam>
                                                                      examAll =
                                                                      snapshot.data ??
                                                                          [];
                                                                  return Column(
                                                                    children: [
                                                                      ListView
                                                                          .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        itemCount:
                                                                            examAll.length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var exam =
                                                                              examAll[index];
                                                                          return FutureBuilder<
                                                                              bool?>(
                                                                            future: fetchAbsenDataExam(
                                                                                context,
                                                                                exam.id,
                                                                                widget.id),
                                                                            builder:
                                                                                (context, attendanceSnapshot) {
                                                                              if (attendanceSnapshot.connectionState == ConnectionState.waiting) {
                                                                                return Center(child: CircularProgressIndicator());
                                                                              } else if (attendanceSnapshot.hasData && attendanceSnapshot.data == true) {
                                                                                return buildTrainingButtonExam(context, true, widget.id, exam.id, allMaterialsAttended, nilai);
                                                                              } else {
                                                                                return buildTrainingButtonExam(context, false, widget.id, exam.id, allMaterialsAttended, nilai);
                                                                              }
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                      FutureBuilder<
                                                                          bool>(
                                                                        future: checkAllAttendance(
                                                                            examAll,
                                                                            context,
                                                                            widget.id),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot.connectionState ==
                                                                              ConnectionState
                                                                                  .waiting) {
                                                                            return Center(child: CircularProgressIndicator());
                                                                          } else if (snapshot.hasData &&
                                                                              snapshot.data == true) {
                                                                            return feedbackButton(
                                                                                context,
                                                                                true,
                                                                                widget.id,
                                                                                nilai);
                                                                          } else {
                                                                            return feedbackButton(
                                                                                context,
                                                                                false,
                                                                                widget.id,
                                                                                nilai);
                                                                          }
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              },
                                                            );
                                                          },
                                                        )
                                                      : Container(),
                                                ],
                                              );
                                            } else {
                                              return Center(
                                                  child: Text(
                                                      'gagal koneksi ke server'));
                                            }
                                          },
                                        )
                                      : widget.isProgress
                                          ? FutureBuilder<List<Exam>?>(
                                              future: futureExam,
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else if (snapshot.hasError) {
                                                  if (snapshot.error ==
                                                      "ujian tidak ada") {
                                                    return Center(
                                                        child: Text(
                                                            'tidak ada ujian'));
                                                  } else {
                                                    return Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .error_outline,
                                                              color: Colors.red,
                                                              size: 30.0,
                                                            ),
                                                            SizedBox(
                                                                height: 16.0),
                                                            Text(
                                                              snapshot.error
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                } else if (snapshot.hasData) {
                                                  List<Exam> examAll =
                                                      snapshot.data ?? [];
                                                  return Column(
                                                    children: [
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            examAll.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var exam =
                                                              examAll[index];
                                                          return FutureBuilder<
                                                              bool?>(
                                                            future:
                                                                fetchAbsenDataExam(
                                                                    context,
                                                                    exam.id,
                                                                    widget.id),
                                                            builder: (context,
                                                                attendanceSnapshot) {
                                                              if (attendanceSnapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                              } else if (attendanceSnapshot
                                                                      .hasData &&
                                                                  attendanceSnapshot
                                                                          .data ==
                                                                      true) {
                                                                return buildTrainingButtonExam(
                                                                    context,
                                                                    true,
                                                                    widget.id,
                                                                    exam.id,
                                                                    true,
                                                                    nilai);
                                                              } else {
                                                                return buildTrainingButtonExam(
                                                                    context,
                                                                    false,
                                                                    widget.id,
                                                                    exam.id,
                                                                    true,
                                                                    nilai);
                                                              }
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      FutureBuilder<bool>(
                                                        future:
                                                            checkAllAttendance(
                                                                examAll,
                                                                context,
                                                                widget.id),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          } else if (snapshot
                                                                  .hasData &&
                                                              snapshot.data ==
                                                                  true) {
                                                            return feedbackButton(
                                                                context,
                                                                true,
                                                                widget.id,
                                                                nilai);
                                                          } else {
                                                            return feedbackButton(
                                                                context,
                                                                false,
                                                                widget.id,
                                                                nilai);
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            )
                                          : Container(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF898989)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alat yang Diperlukan:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D5C96),
                          ),
                        ),
                        SizedBox(height: 10),
                        FutureBuilder<List<Alat>?>(
                          future: futureAlat,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              if (snapshot.error.toString() ==
                                  "Tidak ada alat yang diperlukan") {
                                return Center(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      // Memberikan sudut melengkung
                                      border: Border.all(
                                          color: Colors.red
                                              .shade200), // Memberikan border merah muda
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red.shade700,
                                          // Warna ikon error
                                          size: 30,
                                        ),
                                        SizedBox(width: 12),
                                        // Memberikan jarak antara ikon dan teks
                                        Expanded(
                                          child: Text(
                                            snapshot.error.toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red.shade800,
                                              // Warna teks lebih gelap
                                              fontWeight: FontWeight
                                                  .w500, // Bobot teks lebih ringan agar mudah dibaca
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow
                                                .ellipsis, // Untuk menghindari overflow teks panjang
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            } else if (snapshot.hasData) {
                              final alatList = snapshot.data ?? [];
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: alatList.length,
                                itemBuilder: (context, index) {
                                  final alat = alatList[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.only(
                                            left: 20, top: 5, bottom: 5),
                                        title: Text(
                                          alat.nama,
                                          style: TextStyle(
                                            color: Color(0xFF1D5C96),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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
                  title: 'Apakah anda hadir?',
                  text: 'Tekan ya untuk absen',
                  confirmBtnText: 'Ya',
                  cancelBtnText: 'Tidak',
                  confirmBtnColor: Colors.green,
                  confirmBtnTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                  onConfirmBtnTap: () async {
                    Navigator.of(context).pop();
                    var res = await absenPeserta(
                        context, idMateri, null, idPelaksanaanPelatihan);
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
            if (!isUnlocked)
              Icon(
                Icons.lock,
                color: Colors.red,
              ),
          ],
        ),
      ),
    ),
  );
}

Widget feedbackButton(
    BuildContext context, bool isUnLocked, idPelaksanaanPelatihan, bool nilai) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: GestureDetector(
      onTap: nilai
          ? isUnLocked
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FeedbackPage(idPelaksanaan: idPelaksanaanPelatihan),
                    ),
                  );
                }
              : null
          : null,
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
                'Feedback',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xFF1D5C96),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            if (!isUnLocked || !nilai)
              Icon(
                Icons.lock,
                color: Colors.red,
              ),
          ],
        ),
      ),
    ),
  );
}

Widget buildTrainingButtonExam(BuildContext context, bool isUnlocked,
    idPelaksanaanPelatihan, int idExam, bool checkAbsen, bool nilai) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: GestureDetector(
      onTap: isUnlocked
          ? () {
              checkAbsen
                  ? {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UjianPage(
                            id: idExam,
                            idPelatihan: idPelaksanaanPelatihan,
                            isFinalized: nilai,
                          ),
                        ),
                      )
                    }
                  : null;
            }
          : () {
              checkAbsen
                  ? QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      text: 'Absen',
                      confirmBtnText: 'Ya',
                      cancelBtnText: 'Tidak',
                      confirmBtnColor: Colors.green,
                      confirmBtnTextStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      onConfirmBtnTap: () async {
                        Navigator.of(context).pop();
                        var res = await absenPeserta(
                            context, null, idExam, idPelaksanaanPelatihan);
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
                      })
                  : null;
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
                'UJIAN',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xFF1D5C96),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            if (!isUnlocked)
              Icon(
                Icons.lock,
                color: Colors.red,
              ),
          ],
        ),
      ),
    ),
  );
}

Future<bool> checkAllAttendance(
    List<Exam> examAll, context, idPelatihan) async {
  for (var exam in examAll) {
    final isAbsen = await fetchAbsenDataExam(context, exam.id, idPelatihan);
    if (!isAbsen!) {
      return false;
    }
  }
  return true;
}

Future<bool> checkAllAttendanceMateri(
    List<Materi> materiAll, context, id) async {
  for (var exam in materiAll) {
    final isAbsen = await fetchAbsenDataMateri(context, exam.id, id);
    if (!isAbsen!) {
      return false;
    }
  }
  return true;
}
