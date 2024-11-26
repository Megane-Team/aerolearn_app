import 'package:aerolearn/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KatalogTraining extends StatefulWidget {
  const KatalogTraining({super.key});

  @override
  State<KatalogTraining> createState() => _KatalogTrainingState();
}

class _KatalogTrainingState extends State<KatalogTraining> {
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
                      training[0]['jenis_latihan']!,
                      style: TextStyle(
                          color: Color(0xFF1D5C96),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 18),
                    child: Text(
                      '${training[0]['instruktur']}',
                      style: TextStyle(
                          color: Color(0xFF1D5C96),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
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
                          buildTrainingButton(
                              context, 'Aircraft Configuration Design'),
                          buildTrainingButton(
                              context, 'Aircraft Structure (Structure Design)'),
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

Widget buildTrainingButton(BuildContext context, String title) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: GestureDetector(
      onTap: () {
        context.go("/Materi");
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFF898989)),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: Color(0xFF1D5C96), fontSize: 16.0),
            ),
          ],
        ),
      ),
    ),
  );
}

List<Map<String, String>> training = [
  {
    'jenis_latihan': 'Aircraft Painting',
    'instruktur': 'Muhammad Hafidz',
  }
];
