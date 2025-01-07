import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';
import '../variable/nilai.dart';
import 'package:http/http.dart' as http;

Future<Nilai?> fetchNilai(context, id, idPelaksanaan) async {
  final url = '$baseURL/nilai/$id/$idPelaksanaan';
  final response = await HttpService.getRequest(url);
  if (response.statusCode == 200) {
    return Nilai.fromJson(json.decode(response.body)['data']);
  } else if (response.statusCode == 401) {
    throw 'nilai tidak ada';
  } else if (response.statusCode == 400) {
    throw 'unauthorized';
  } else if (response.statusCode == 500) {
    throw 'server error';
  } else {
    return null;
  }
}
