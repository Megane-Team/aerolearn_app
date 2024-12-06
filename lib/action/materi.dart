import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/materi.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<List<Materi>> fetchMateriData(id) async {
  final url = '$baseURL/materi/$id';
  final response = await HttpService.getRequest(url);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Materi.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load training data');
  }
}
