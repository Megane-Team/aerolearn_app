import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';

class SertifikatList extends StatefulWidget {
  const SertifikatList({super.key});

  @override
  State<SertifikatList> createState() => _SertifikatListState();
}

class _SertifikatListState extends State<SertifikatList> {
  @override
  void initState() {
    super.initState();
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
        body: Column(
          children: [
            SizedBox(height: 14),
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.92,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF898989)),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            )),
          ],
        ));
  }
}
