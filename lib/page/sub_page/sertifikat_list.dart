import 'package:aerolearn/action/sertifikat.dart';
import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/e_sertifikat.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SertifikatList extends StatefulWidget {
  const SertifikatList({super.key});

  @override
  State<SertifikatList> createState() => _SertifikatListState();
}

class _SertifikatListState extends State<SertifikatList> {
  late Future<List<Esertifikat>?> futureSertifikatData;

  @override
  void initState() {
    super.initState();
    futureSertifikatData = fetchSertifikat(context);
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
                    'Katalog Sertifikat',
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
        backgroundColor: Color(0xFFEDEDED),
        body: FutureBuilder(
            future: futureSertifikatData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List<Esertifikat>? sertifikat = snapshot.data;
                if (sertifikat!.isEmpty) {
                  return Center(child: Text('No Sertifikat'));
                }
                return ListView.builder(
                    itemCount: sertifikat.length,
                    itemBuilder: (context, index) {
                      var eSertifikat = sertifikat[index];
                      return Column(
                        children: [
                          SizedBox(height: 14),
                          Center(
                              child: Container(
                            width: MediaQuery.of(context).size.width * 0.92,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF898989)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: SfPdfViewer.network(
                                '$baseURL/public/e-sertifikat/${eSertifikat.sertifikasi}'),
                          )),
                        ],
                      );
                    });
              } else {
                return Center(
                  child: Text('connection error'),
                );
              }
            }));
  }
}
