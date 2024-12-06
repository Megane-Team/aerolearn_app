import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<bool> fetchAbsenData(idMateri) async {
  final url = '$baseURL/absensi/';
  final response = await HttpService.getRequest(url);
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse['status_absen'] == "Hadir";
  } else {
    throw Exception('Failed to load absensi data');
  }
}
