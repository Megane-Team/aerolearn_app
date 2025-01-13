import 'dart:convert';
import 'dart:io'; // Untuk menangani SocketException
import 'package:aerolearn/variable/exam.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/constant/variable.dart';

Future<List<Exam>?> fetchExamData(context, id) async {
  final url = '$baseURL/exam/$id';

  try {
    final response = await HttpService.getRequest(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((data) => Exam.fromJson(data)).toList();
    } else if (response.statusCode == 401) {
      throw 'Ujian tidak ada';
    } else if (response.statusCode == 400) {
      throw 'Unauthorized';
    } else if (response.statusCode == 500) {
      throw 'Server error';
    } else {
      throw 'Unexpected error occurred';
    }
  } on SocketException {
    throw 'tidak dapat terhubung ke server';
  } catch (e) {
    rethrow;
  }
}
