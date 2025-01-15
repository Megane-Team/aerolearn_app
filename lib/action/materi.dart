import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/materi.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';
import 'dart:io';

Future<List<Materi>?> fetchMateriData(context, id) async {
  final url = '$baseURL/materi/$id';

  try {
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((data) => Materi.fromJson(data)).toList();
    } else if (response.statusCode == 401) {
      throw 'Materi tidak ada';
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
