import 'dart:convert';
import 'dart:io'; // Untuk menangani SocketException

import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import '../variable/nilai.dart';

Future<Nilai?> fetchNilai(context, id, idPelaksanaan) async {
  final url = '$baseURL/nilai/$id/$idPelaksanaan';
  try {
    final response = await HttpService.getRequest(url);

    if (response.statusCode == 200) {
      return Nilai.fromJson(json.decode(response.body)['data']);
    } else if (response.statusCode == 401) {
      throw 'Nilai tidak ada';
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
