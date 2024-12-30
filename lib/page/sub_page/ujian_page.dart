import 'package:flutter/material.dart';

class UjianPage extends StatefulWidget {
  const UjianPage({super.key});

  @override
  State<UjianPage> createState() => _UjianPageState();
}

class _UjianPageState extends State<UjianPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Color(0xFF12395D)),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: Center(
                child: Text(
                  'Ujian',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF12395D),
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}
