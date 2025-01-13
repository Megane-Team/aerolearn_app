import 'dart:convert';
import 'dart:io'; // Untuk menangani SocketException

import 'package:aerolearn/variable/question.dart';
import '../constant/variable.dart';
import '../utils/http.dart';

Future<List<Question>?> fetchQuestion(context, id) async {
  final url = '$baseURL/exam/question/$id';
  try {
    final response = await HttpService.getRequest(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((data) => Question.fromJson(data)).toList();
    } else if (response.statusCode == 401) {
      throw 'Pertanyaan tidak ada';
    } else if (response.statusCode == 400) {
      throw 'Unauthorized';
    } else if (response.statusCode == 500) {
      throw 'Server error';
    } else {
      throw 'Unexpected error occurred';
    }
  } on SocketException {
    throw 'Jaringan tidak dapat dijangkau. Pastikan koneksi internet Anda tersedia.';
  } catch (e) {
    rethrow;
  }
}
