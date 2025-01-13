import 'dart:convert';
import 'dart:io'; // Import untuk menangani SocketException

import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/variable/notifications.dart';

Future<List<Notifications>?> fetchNotifications(context, id) async {
  final url = '$baseURL/notification/$id';
  try {
    final response = await HttpService.getRequest(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((item) => Notifications.fromJson(item)).toList();
    } else if (response.statusCode == 401) {
      throw 'Notifikasi tidak ada';
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
