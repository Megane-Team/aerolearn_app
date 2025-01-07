import 'package:aerolearn/utils/connection_error.dart';
import 'package:aerolearn/utils/http.dart';
import 'package:aerolearn/utils/session.dart';
import 'dart:convert';
import 'package:aerolearn/constant/variable.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String?> login(context, String email, String password) async {
    try {
      final url = '$baseURL/user/login';
      final response = await HttpService.postRequest(
          url, {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final token = responseBody['token'];
        final userRole = responseBody['user_role'];
        await SessionService.storeToken(token);
        return userRole;
      } else if (response.statusCode == 401) {
        return 'invalid';
      } else if (response.statusCode == 400) {
        throw 'unauthorized';
      } else if (response.statusCode == 500) {
        throw 'server error';
      } else {
        throw 'koneksi error';
      }
    } on http.ClientException {
      showConnectionErrorDialog(context);
    } catch (e) {
      showConnectionErrorDialog(context);
    }
    return null;
  }
}
