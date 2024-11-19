import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class SessionService {
  static Future<void> storeToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> logout() async {
    await storage.delete(key: 'token');
  }
}
