
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const FlutterSecureStorage storage =
      FlutterSecureStorage();

  static const String tokenKey = 'auth_token';

  // In-memory token
  static String? tokenValue;

  static String? get token => tokenValue;

  static bool get hasToken =>
      tokenValue != null && tokenValue!.isNotEmpty;

  // Initialize token from secure storage
  static Future<void> init() async {
    tokenValue = await storage.read(key: tokenKey);
  }

  // Save token securely
  static Future<void> saveToken(String token) async {
    await storage.write(
      key: tokenKey,
      value: token,
    );

    tokenValue = token;
  }

  // Delete token
  static Future<void> deleteToken() async {
    await storage.delete(key: tokenKey);

    tokenValue = null;
  }
}
