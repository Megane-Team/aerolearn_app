import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/connection_error.dart';
import 'package:aerolearn/variable/jenis_training.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<List<Training>?> fetchTrainingData(context) async {
  final url = '$baseURL/training/';
  final response = await HttpService.getRequest(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> data = jsonResponse['data'];
    return data.map((item) => Training.fromJson(item)).toList();
  } else if (response.statusCode == 401) {
    throw 'tidak ada pelatihan';
  } else if (response.statusCode == 400) {
    throw 'unauthorized';
  } else if (response.statusCode == 500) {
    throw 'server error';
  } else {
    showConnectionErrorDialog(context);
    return null;
  }
}

Future<Training?> fetchTrainingDetail(context, id) async {
  try {
    final url = '$baseURL/training/$id';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Training.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Failed to load training data');
    }
  } catch (e) {
    return null;
  }
}
