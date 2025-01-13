import 'dart:convert';

import 'package:aerolearn/variable/answer.dart';

import '../constant/variable.dart';
import '../utils/http.dart';

Future<Jawaban?> fetchAnswer(context, idUser, idQuestion, idPelatihan) async {
  final url = '$baseURL/exam/question/jawaban/$idUser/$idQuestion/$idPelatihan';
  final response = await HttpService.getRequest(url);
  if (response.statusCode == 200) {
    return Jawaban.fromJson(json.decode(response.body)['data']);
  } else {
    return null;
  }
}
