import 'package:flutter/material.dart';

class Feedback extends StatefulWidget {
  const Feedback({super.key});

  @override
  State<Feedback> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  final _formKey = GlobalKey<FormState>();
  final _opinionController = TextEditingController();
  final _learnedController = TextEditingController();
  final _hopeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child: Text(
                    'Feedback',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff12395D),
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFEDEDED),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      'Bagaimana pendapatmu tentang pelatihan',
                      style: TextStyle(fontSize: 16, color: Color(0xFF12395D)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11),
                    child: TextFormField(
                      controller: _opinionController,
                      decoration: InputDecoration(
                        hintText: 'Harap isi sesuai pendapatmu',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF9D9D9D))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7C7C7C))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Harap isi pendapatmu';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      'Apa yang kamu dapatkan dari pelatihan',
                      style: TextStyle(fontSize: 16, color: Color(0xFF12395D)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11),
                    child: TextFormField(
                      controller: _learnedController,
                      decoration: InputDecoration(
                        hintText: 'Isi sesuai pendapatmu',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF9D9D9D))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7C7C7C))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'isi pendapatmu';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      'Apakah ada tambahan dan saran untuk pelatihan ini?',
                      style: TextStyle(fontSize: 16, color: Color(0xFF12395D)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11),
                    child: TextFormField(
                      controller: _hopeController,
                      decoration: InputDecoration(
                        hintText: 'Isi sesuai pendapatmu',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF9D9D9D))),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF7C7C7C)),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'isi pendapatmu';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
                SizedBox(height: 90),
                SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Mendapatkan teks dari TextFormField
                      final opinion = _opinionController.text;
                      final learned = _learnedController.text;
                      final hope = _hopeController.text;

                      //proses data
                      print('pendapat: $opinion');
                      print('pelajaran: $learned');
                      print('sesuai harapan: $hope');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Menigirim Feedback')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1D5C96),
                      foregroundColor: Colors.white,
                      minimumSize: Size(230, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Kirim',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
