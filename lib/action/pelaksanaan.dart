import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<List<PelaksanaPelatihan>?> fetchPelaksanaanTraining(context) async {
  try {
    final url = '$baseURL/peserta/progress';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((item) => PelaksanaPelatihan.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load training data');
    }
  } catch (e) {
    return null;
  }
}
