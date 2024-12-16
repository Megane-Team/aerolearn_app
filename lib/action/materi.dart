import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/connectionError.dart';
import 'package:aerolearn/variable/materi.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<List<Materi>?> fetchMateriData(context, id) async {
  try {
    final url = '$baseURL/materi/$id';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((data) => Materi.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load training data');
    }
  } catch (e) {
    showConnectionErrorDialog(context);
    return null;
  }
}
