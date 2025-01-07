import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/pelaksanaan.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<PelaksanaanPelatihan>?> fetchPelaksanaanTraining(
    context, id) async {
    final url = '$baseURL/peserta/progress/$id';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((item) => PelaksanaanPelatihan.fromJson(item)).toList();
    } else if (response.statusCode == 401) {
      throw 'tidak ada pelatihan';
    } else if (response.statusCode == 400) {
      throw 'unauthorized';
    } else if (response.statusCode == 500) {
      throw 'server error';
    } else {
      return null;
    }
}
