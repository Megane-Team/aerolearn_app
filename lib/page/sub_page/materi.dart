import 'package:aerolearn/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Materi extends StatefulWidget {
  const Materi({super.key});

  @override
  State<Materi> createState() => _MateriState();
}

class _MateriState extends State<Materi> {
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
                context.go('/katalog');
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Materi Pelatihan',
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
      body: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child: SfPdfViewer.asset(Assets.files('AgingAircraftTraining2024')),
        ),
      ),
    );
  }
}
