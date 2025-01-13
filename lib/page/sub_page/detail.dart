import 'package:aerolearn/variable/jenis_training.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';
import 'package:aerolearn/action/jenis_training.dart';

class Detail extends StatefulWidget {
  final String id;
  const Detail({super.key, required this.id});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Future<Training?>? _trainingDetail;

  @override
  void initState() {
    super.initState();
    _trainingDetail = fetchTrainingDetail(context, widget.id);
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
                    'Rincian Pelatihan',
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
        body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 1),
          child: FutureBuilder<Training?>(
            future: _trainingDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
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
              } else if (!snapshot.hasData) {
                return Center(child: Text('tidak ada data pelatihan'));
              } else {
                final training = snapshot.data!;
                return ListView(
                  children: [
                    RincianTraining(
                      koordinator: training.koordinator,
                      training: training.nama,
                      description: training.deskripsi,
                      category: training.kategori,
                    ),
                  ],
                );
              }
            },
          ),
        ));
  }
}

class RincianTraining extends StatelessWidget {
  final String koordinator;
  final String training;
  final String description;
  final String category;

  const RincianTraining({
    super.key,
    required this.koordinator,
    required this.training,
    required this.description,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.92,
                height: 120,
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
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 22, left: 18),
                            child: Text(
                              training,
                              style: TextStyle(
                                color: Color(0xFF1D5C96),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2, // Added letter spacing
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4, left: 18),
                            child: Text(
                              koordinator,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          category,
                          style: TextStyle(
                            color: Color(0xFF1D5C96),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(2.0, 2.0),
                              ),
                            ], // Added shadow for a stylish effect
                          ),
                        ),
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
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF898989)),
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [Text(description)],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
