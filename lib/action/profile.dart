import 'package:aerolearn/constant/variable.dart';
import 'package:aerolearn/utils/http.dart';
import 'dart:convert';
import 'package:aerolearn/controller/profile.dart';

Future<UserProfile> fetchUserProfile() async {
  final url = '$baseURL/profile';
  final response = await HttpService.getRequest(url);
  if (response.statusCode == 200) {
    return UserProfile.fromJson(json.decode(response.body)['data']);
  } else {
    throw Exception('Failed to load user profile');
  }
}
