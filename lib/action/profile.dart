import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/connectionError.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';
import 'package:aerolearn/variable/profile.dart';

Future<UserProfile?> fetchUserProfile(context) async {
  try {
    final url = '$baseURL/user/profile';
    final response = await HttpService.getRequest(url);
    if (response.statusCode == 200) {
      return UserProfile.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load user profile');
    }
  } catch (e) {
    showConnectionErrorDialog(context);
    return null;
  }
}
