import 'package:aerolearn/action/feedback.dart';
import 'package:aerolearn/action/feedback_post.dart';
import 'package:flutter/material.dart';
import '../../variable/feedback.dart' as feedback;

class FeedbackPage extends StatefulWidget {
  final int idPelaksanaan;
  const FeedbackPage({super.key, required this.idPelaksanaan});

  @override
  State<FeedbackPage> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackPage> {
  Map<int, String> feedbackAnswers = {};
  late Future<List<feedback.Feedback>?> futureFeedback;
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    futureFeedback = fetchFeedbackData(context);
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          child: FutureBuilder<List<feedback.Feedback>?>(
              future: futureFeedback,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  if (snapshot.error == 'feedback tidak ada') {
                    return Center(child: Text('Tidak ada feedback'));
                  } else {
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
                  }
                } else if (snapshot.hasData) {
                  List<feedback.Feedback> feedbackQuestion =
                      snapshot.data ?? [];
                  if (feedbackQuestion.isEmpty) {
                    return Center(child: Text('Tidak ada feedback'));
                  }
                  _controllers = List.generate(feedbackQuestion.length,
                      (index) => TextEditingController());
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: feedbackQuestion.length,
                            itemBuilder: (context, index) {
                              var question = feedbackQuestion[index];
                              return Column(
                                children: [
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 5),
                                        child: Text(
                                          question.text,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF12395D)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(11),
                                        child: TextFormField(
                                          controller: _controllers[index],
                                          decoration: InputDecoration(
                                            hintText:
                                                'Harap isi sesuai pendapatmu',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF9D9D9D))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF7C7C7C))),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                          ),
                                          maxLines: 3,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Harap isi pendapatmu';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            feedbackAnswers[question.id] =
                                                value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await sendAllFeedbackAnswers(
                                    context,
                                    feedbackAnswers,
                                    widget.idPelaksanaan as int?,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1D5C96),
                                foregroundColor: Colors.white,
                                minimumSize: Size(230, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Kirim Semua',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
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
                            'tidak dapat terhubung ke server',
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
                }
              }),
        ));
  }
}

Future<void> sendAllFeedbackAnswers(BuildContext context,
    Map<int, String> feedbackAnswers, int? idPelaksanaan) async {
  final currentContext = context;

  for (var entry in feedbackAnswers.entries) {
    var result = await feedbackAnswer(
      currentContext,
      entry.value,
      entry.key,
      idPelaksanaan!,
    );

    if (result != null) {
      // ignore: use_build_context_synchronously
      showDialog(
        // ignore: use_build_context_synchronously
        context: currentContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Informasi'),
            content: Text(result),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      if (!currentContext.mounted) return;
      ScaffoldMessenger.of(currentContext).showSnackBar(
        SnackBar(content: Text('Error sending feedback')),
      );
    }
  }
}
