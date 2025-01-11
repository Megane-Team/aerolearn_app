// ignore_for_file: use_build_context_synchronously

import 'package:aerolearn/action/question.dart';
import 'package:aerolearn/variable/profile.dart';
import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';

import '../../action/jawaban.dart';
import '../../action/jawaban_post.dart';
import '../../action/nilai_post.dart';
import '../../action/options.dart';
import '../../action/profile.dart';
import '../../variable/answer.dart';
import '../../variable/options.dart';
import '../../variable/question.dart';

class UjianPage extends StatefulWidget {
  final int id;
  final int idPelatihan;
  const UjianPage({super.key, required this.id, required this.idPelatihan});

  @override
  State<UjianPage> createState() => _UjianPageState();
}

class _UjianPageState extends State<UjianPage> {
  int _groupValue = 1;
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  List<Options> _options = [];
  UserProfile? _userProfile;
  Jawaban? _jawaban;
  Map<int, int> _idToGroupValue = {};
  Map<int, int> _groupValueToId = {};
  void _handleRadioValueChange(int? value) {
    setState(() {
      _groupValue = value ?? 1;
    });
  }

  Future<void> fetchData() async {
    try {
      _userProfile = await fetchUserProfile(context);
      final questions = await fetchQuestion(context, widget.id);
      setState(() {
        _questions = questions ?? [];
      });
      if (_questions.isNotEmpty) {
        await fetchOptionsForCurrentQuestion();
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> fetchOptionsForCurrentQuestion() async {
    try {
      _jawaban = await fetchAnswer(context, _userProfile!.id,
          _questions[_currentQuestionIndex].id, widget.idPelatihan);
      final options =
          await fetchOptions(context, _questions[_currentQuestionIndex].id);
      setState(() {
        _options = options ?? [];
        _idToGroupValue = {
          for (var i = 0; i < _options.length; i++) _options[i].id: i + 1
        };
        _groupValueToId = {
          for (var i = 0; i < _options.length; i++) i + 1: _options[i].id
        };
        _groupValue = _idToGroupValue[_jawaban?.idOpsiJawaban] != null
            ? _idToGroupValue[_jawaban!.idOpsiJawaban]! - 1
            : _options.first.id;
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _nextQuestion() async {
    final jawaban = Jawaban(
      id: _jawaban?.id ?? 0,
      idOpsiJawaban: _groupValueToId[_groupValue] != null
          ? _groupValueToId[_groupValue]! + 1
          : _options.first.id,
      idPelaksanaanPelatihan: widget.idPelatihan,
      idQuestion: _questions[_currentQuestionIndex].id,
    );
    await AnswerPost(context, jawaban.id, jawaban.idOpsiJawaban,
        jawaban.idQuestion, _userProfile!.id, jawaban.idPelaksanaanPelatihan);
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _groupValue = 1;
        fetchOptionsForCurrentQuestion();
      }
    });
  }

  void _previousQuestion() async {
    final jawaban = Jawaban(
      id: _jawaban?.id ?? 0,
      idOpsiJawaban: _groupValueToId[_groupValue] != null
          ? _groupValueToId[_groupValue]! + 1
          : _options.first.id,
      idPelaksanaanPelatihan: widget.idPelatihan,
      idQuestion: _questions[_currentQuestionIndex].id,
    );
    await AnswerPost(context, jawaban.id, jawaban.idOpsiJawaban,
        jawaban.idQuestion, _userProfile!.id, jawaban.idPelaksanaanPelatihan);
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
        _groupValue = 1;
        fetchOptionsForCurrentQuestion();
      }
    });
  }

  void _endExam() async {
    final jawaban = Jawaban(
      id: _jawaban?.id ?? 0,
      idOpsiJawaban: _groupValueToId[_groupValue] != null
          ? _groupValueToId[_groupValue]! + 1
          : _options.first.id,
      idPelaksanaanPelatihan: widget.idPelatihan,
      idQuestion: _questions[_currentQuestionIndex].id,
    );
    await AnswerPost(context, jawaban.id, jawaban.idOpsiJawaban,
        jawaban.idQuestion, _userProfile!.id, jawaban.idPelaksanaanPelatihan);
    showDialog(
      // ignore: duplicate_ignore
      // ignore: use_build_context_synchronously
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Akhiri Ujian'),
          content: Text('Apakah Anda yakin ingin mengakhiri ujian?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                addNilai(_userProfile!.id, jawaban.idPelaksanaanPelatihan);
                Navigator.of(context).pop();
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
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
                  'Ujian',
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
        child: _questions.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Ujian(
                    nomorPertanyaan:
                        'Pertanyaan ${_currentQuestionIndex + 1} dari ${_questions.length}',
                    pertanyaan: _questions[_currentQuestionIndex].question,
                    pilihan: _options.map((option) => option.jawaban).toList(),
                    gambar: _questions[_currentQuestionIndex].gambar,
                    groupValue: _groupValue,
                    onChanged: _handleRadioValueChange,
                  ),
                ],
              ),
      ),
      bottomNavigationBar: _questions.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_currentQuestionIndex > 0)
                    ElevatedButton(
                      onPressed: _previousQuestion,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Sebelumnya'),
                    ),
                  if (_currentQuestionIndex < _questions.length - 1)
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1D5C96),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Selanjutnya'),
                    ),
                  if (_currentQuestionIndex == _questions.length - 1)
                    ElevatedButton(
                      onPressed: _endExam,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1D5C96),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Akhiri Ujian'),
                    ),
                ],
              ),
            ),
    );
  }
}

class Ujian extends StatelessWidget {
  final String nomorPertanyaan;
  final String pertanyaan;
  final List<String> pilihan;
  final int groupValue;
  final String? gambar;
  final ValueChanged<int?> onChanged;
  const Ujian({
    super.key,
    required this.nomorPertanyaan,
    required this.pertanyaan,
    required this.pilihan,
    required this.gambar,
    required this.groupValue,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Center(
          child: Text(nomorPertanyaan),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pertanyaan),
                SizedBox(height: 10),
                gambar != null
                    ? FutureBuilder<Widget>(
                        future: Assets.filesKonten(gambar!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            return snapshot.data!;
                          } else {
                            return Center(
                                child: Text('Gagal koneksi ke server'));
                          }
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        SizedBox(height: 35),
        SafeArea(
          child: Column(
            children: pilihan
                .asMap()
                .entries
                .map(
                  (entry) => ListTile(
                    title: Text(entry.value),
                    leading: Radio(
                      value: entry.key,
                      groupValue: groupValue,
                      onChanged: onChanged,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
