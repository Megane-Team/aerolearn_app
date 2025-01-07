import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/variable/notifications.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Notifications>?> fetchNotifications(context, id) async {
  final url = '$baseURL/notification/$id';
  final response = await HttpService.getRequest(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> data = jsonResponse['data'];
    return data.map((item) => Notifications.fromJson(item)).toList();
  } else if (response.statusCode == 401) {
    throw 'notifikasi tidak ada';
  } else if (response.statusCode == 400) {
    throw 'unauthorized';
  } else if (response.statusCode == 500) {
    throw 'server error';
  } else {
    return null;
  }
}
