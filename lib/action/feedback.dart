import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';
import 'package:aerolearn/variable/feedback.dart';

Future<List<Feedback>?> fetchFeedbackData(context) async {
  try {
    final url = '$baseURL/feedback/';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((data) => Feedback.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load training data');
    }
  } catch (e) {
    return null;
  }
}
