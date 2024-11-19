// ignore: depend_on_referenced_packages
import 'package:aerolearn/utils/session.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  static Future<http.Response> postRequest(
      String url, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response;
  }

  static Future<http.Response> getRequest(String url) async {
    final token = await SessionService.getToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'authorization': 'Bearer $token',
      },
    );
    return response;
  }
}
