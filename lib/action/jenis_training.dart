import 'dart:convert';
import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/connection_error.dart';
import 'package:aerolearn/variable/jenis_training.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:io'; // For SocketException

Future<List<Training>?> fetchTrainingData(context) async {
  final url = '$baseURL/training/';

  try {
    final response = await HttpService.getRequest(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((item) => Training.fromJson(item)).toList();
    } else {
      throw 'Terjadi kesalahan: ${response.statusCode}';
    }
  } on SocketException {
    showConnectionErrorDialog(context);
    // Network error (e.g., no internet connection)
    throw 'tidak dapat terhubung ke server';
  } on HttpException {
    throw 'Server error';
  } catch (e) {
    rethrow;
  }
}

Future<Training?> fetchTrainingDetail(context, id) async {
  final url = '$baseURL/training/$id';

  try {
    final response = await HttpService.getRequest(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Training.fromJson(jsonResponse['data']);
    } else {
      throw 'Failed to load training data, status code: ${response.statusCode}';
    }
  } on SocketException {
    throw 'tidak dapat terhubung ke server';
  } catch (e) {
    rethrow;
  }
}
