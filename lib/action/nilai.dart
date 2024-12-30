import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';
import '../variable/nilai.dart';

Future<nilai?> fetchNilai(context, id, idPelaksanaan) async {
  try {
    final url = '$baseURL/nilai/$id/$idPelaksanaan';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      return nilai.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load training data');
    }
  } catch (e) {
    return null;
  }
}
