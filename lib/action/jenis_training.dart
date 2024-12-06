import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/jenis_training.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<List<Training>> fetchTrainingData() async {
  final url = '$baseURL/training/';
  final response = await HttpService.getRequest(url);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Training.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load training data');
  }
}
