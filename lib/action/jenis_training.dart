import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/connection_error.dart';
import 'package:aerolearn/variable/jenis_training.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<List<Training>?> fetchTrainingData(context) async {
  try {
    final url = '$baseURL/training/';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((item) => Training.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load training data');
    }
  } catch (e) {
    showConnectionErrorDialog(context);
    return null;
  }
}
