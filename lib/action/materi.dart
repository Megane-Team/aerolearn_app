import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/materi.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';

Future<List<Materi>?> fetchMateriData(context, id) async {
    final url = '$baseURL/materi/$id';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((data) => Materi.fromJson(data)).toList();
    } else if (response.statusCode == 401) {
      throw 'materi tidak ada';
    } else if (response.statusCode == 400) {
      throw 'unauthorized';
    } else if (response.statusCode == 500) {
      throw 'server error';
    } else {
      return null;
    }
}
