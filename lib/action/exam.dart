import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/exam.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<List<Exam>?> fetchExamData(context, id) async {
  try {
    final url = '$baseURL/exam/$id';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((data) => Exam.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load training data');
    }
  } catch (e) {
    return null;
  }
}
