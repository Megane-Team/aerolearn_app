import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/e_sertifikat.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<List<Esertifikat>?> fetchSertifikat(context) async {
  try {
    final url = '$baseURL/sertifikat/user';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((item) => Esertifikat.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load training data');
    }
  } catch (e) {
    return null;
  }
}
