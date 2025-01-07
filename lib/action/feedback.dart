import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';
import 'package:aerolearn/variable/feedback.dart';

Future<List<Feedback>?> fetchFeedbackData(context) async {
  final url = '$baseURL/feedback/';
  final response = await HttpService.getRequest(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> data = jsonResponse['data'];
    return data.map((data) => Feedback.fromJson(data)).toList();
  } else if (response.statusCode == 401) {
    throw 'feedback tidak ada';
  } else if (response.statusCode == 400) {
    throw 'unauthorized';
  } else if (response.statusCode == 500) {
    throw 'server error';
  } else {
    return null;
  }
}
