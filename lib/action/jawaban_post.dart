// ignore_for_file: file_names
import 'dart:convert';
import 'package:aerolearn/utils/connection_error.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/constant/variable.dart';

// ignore: non_constant_identifier_names
Future<String?> AnswerPost(context, int? id, int? idOpsiJawaban, int idQuestion,
    int idUser, idPelatihan) async {
  try {
    final url = id != 0
        ? '$baseURL/exam/question/jawaban/$id'
        : '$baseURL/exam/question/jawaban';
    final response = await HttpService.postRequest(url, {
      'id_peserta': idUser,
      'id_pelaksanaan_pelatihan': idPelatihan,
      'id_question': idQuestion,
      'id_opsi_jawaban': idOpsiJawaban,
    });
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    } else {
      throw Exception('Failed to answer');
    }
  } catch (e) {
    showConnectionErrorDialog(context);
    return null;
  }
}
