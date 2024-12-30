// ignore: file_names
import 'dart:convert';
import 'package:aerolearn/utils/connectionError.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/constant/variable.dart';

Future<String?> feedbackAnswer(
    context, String text, int idFeedbackQuestion, int idPelaksanaanPelatihan) async {
  try {
    final url = '$baseURL/feedback/+';
    final response = await HttpService.postRequest(url, {
      'text': text,
      'id_feedbackQuestion': idFeedbackQuestion,
      'id_pelaksanaanPelatihan': idPelaksanaanPelatihan,
    });
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    } else {
      return 'anda sudah melakukan feedback';
    }
  } catch (e) {
    showConnectionErrorDialog(context);
    return null;
  }
}

