import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<List<PelaksanaanPelatihan>> fetchPelaksanaanTrainining() async {
  final url = '$baseURL/peserta/progress';
  final response = await HttpService.getRequest(url);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((data) => PelaksanaanPelatihan.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load training data');
  }
}
