import 'dart:convert';
import 'package:aerolearn/utils/connection_error.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/constant/variable.dart';

Future<String?> feedbackAnswer(context, String text, int idFeedbackQuestion,
    int idPelaksanaanPelatihan) async {
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
    } else if (response.statusCode == 401) {
      return 'anda sudah melakukan feedback';
    } else {
      throw Exception('feedback gagal disimpan');
    }
  } catch (e) {
    showConnectionErrorDialog(context);
    return null;
  }
}
