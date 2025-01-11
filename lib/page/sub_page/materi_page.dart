import 'package:aerolearn/utils/asset.dart';
import 'package:flutter/material.dart';

class MateriPage extends StatefulWidget {
  final String konten;
  const MateriPage({
    super.key,
    required this.konten,
  });

  @override
  State<MateriPage> createState() => _MateriState();
}

class _MateriState extends State<MateriPage> {
  Future<Widget>? _pdfViewer;
  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  void _loadPDF() {
    setState(() {
      _pdfViewer = Assets.filesMateri(widget.konten);
    });
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
          child: FutureBuilder<Widget>(
            future: _pdfViewer,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return snapshot.data!;
              } else {
                return Center(child: Text('gagal koneksi ke server'));
              }
            },
          ),
        ),
      ),
    );
  }
}
