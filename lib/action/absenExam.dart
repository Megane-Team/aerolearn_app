// ignore_for_file: file_names

import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<bool?> fetchAbsenDataExam(context, idExam) async {
  try {
    final url = '$baseURL/absensi/exam/$idExam';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['status_absen'] == "Validasi";
    } else {
      throw Exception('Failed to load absensi data');
    }
  } catch (e) {
    return false;
  }
}
