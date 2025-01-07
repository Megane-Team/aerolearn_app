// ignore_for_file: file_names

import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<bool?> fetchAbsenDataMateri(context, idMateri, idPelaksanaan) async {
  try {
    final url = '$baseURL/absensi/materi/$idMateri/$idPelaksanaan';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['status_absen'] == "Validasi";
    } else if (response.statusCode == 401) {
      return false;
    } else if (response.statusCode == 400) {
      return false;
    } else if (response.statusCode == 500) {
      return false;
    } else {
      return false;
    }
  } on http.ClientException {
    return false;
  } catch (e) {
    return false;
  }
}
