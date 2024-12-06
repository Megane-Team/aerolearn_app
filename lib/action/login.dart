import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/utils/session.dart';
import 'dart:convert';
import 'package:aerolearn/constant/variable.dart';

class ApiService {
  static Future<String?> login(String email, String password) async {
    final url = '$baseURL/user/login';
    final response = await HttpService.postRequest(
        url, {'email': email, 'password': password});

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      final userRole = responseBody['user_role'];
      await SessionService.storeToken(token);
      return userRole;
    } else {
      return null;
    }
  }
}
