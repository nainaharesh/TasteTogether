
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  

  static const storage = FlutterSecureStorage();
  static const tokenKey = 'auth token';

  // Memory cache for synchronous token access
  static String? token;

  // Get the currently stored token from memory
  static String? get token => token;

  // Check whether a token exists
  static bool get hasToken => token != null && token!.isNotEmpty;

  // Initialize token from secure storage
  static Future<void> init() async {
    token = await storage.read(key: tokenKey);
  }

  // Save token after successful login
  static Future<void> saveToken(String token) async {
    await storage.write(key: tokenKey, value: token);
    token = token;
  }

  // Delete token during logout or unauthorized session
  static Future<void> deleteToken() async {
    await storage.delete(key: tokenKey);
    token = null;
  }
}
