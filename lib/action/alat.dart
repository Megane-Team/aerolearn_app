import 'dart:convert';
import 'dart:io'; // Untuk menangani SocketException
import 'package:aerolearn/variable/alat.dart';
import '../constant/variable.dart';
import '../utils/http.dart';

Future<List<Alat>?> fetchAlat(context, id) async {
  final url = '$baseURL/alat/$id';

  try {
    final response = await HttpService.getRequest(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((data) => Alat.fromJson(data)).toList();
    } else if (response.statusCode == 401) {
      throw 'Tidak ada alat yang diperlukan';
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
