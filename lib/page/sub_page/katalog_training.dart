import 'package:aerolearn/action/absen.dart';
import 'package:aerolearn/action/materi.dart';
import 'package:aerolearn/utils/asset.dart';
import 'package:aerolearn/variable/materi.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KatalogTraining extends StatefulWidget {
  final String? id;
  final String instruktur;
  final String training;
  const KatalogTraining(
      {super.key,
      required this.id,
      required this.instruktur,
      required this.training});

  @override
  State<KatalogTraining> createState() => _KatalogTrainingState();
}

class _KatalogTrainingState extends State<KatalogTraining> {
  late Future<List<Materi>> futureMateri;
  bool isLocked = false;

  @override
  void initState() {
    super.initState();
    futureMateri = fetchMateriData(widget.id);
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
                context.go("/mainpage");
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
                      child: Column(
                        children: [
                          FutureBuilder<List<Materi>>(
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
                                      return FutureBuilder<bool>(
                                        future: fetchAbsenData(materi.id),
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
                                          } else if (attendanceSnapshot
                                                  .hasData &&
                                              attendanceSnapshot.data == true) {
                                            var id = materi.id;
                                            return buildTrainingButton(
                                                context,
                                                materi.judul,
                                                "/materi?id=$id",
                                                true,
                                                materi.konten);
                                          } else {
                                            return buildTrainingButton(
                                                context,
                                                materi.judul,
                                                "/materi",
                                                false,
                                                materi.konten);
                                          }
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                      child: Text('No data available'));
                                }
                              })
                        ],
                      ),
                    ),
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

Widget buildTrainingButton(
    BuildContext context, String title, String route, bool isUnlocked, konten) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: GestureDetector(
      onTap: isUnlocked
          ? () {
              context.go(route, extra: konten);
            }
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
