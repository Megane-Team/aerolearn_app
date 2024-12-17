import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';


class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
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
      body: Padding(
          padding: EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Aircraft Basic Training',
            style: TextStyle(
              color: Color(0xFF12395D),
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child: Column(
                children: [
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
              ),)
        ],
      ),
      ),
    );
  }
}
