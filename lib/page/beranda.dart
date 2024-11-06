import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Row(
          children: [Text('Hi, Hafidz!'),
          SizedBox(width: 10),
            Icon(Icons.person),
            Spacer(),
            Icon(Icons.notifications)
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
