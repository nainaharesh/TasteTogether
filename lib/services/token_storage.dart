// ignore_for_file: deprecated_member_use
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const storage = FlutterSecureStorage();
  static const tokenKey = 'auth_token';

  /// Memory cache. Secure storage async hota hai, is liye token ek baar
  /// padh kar yahan rakh lete hain taake baaki jagah sync mil jaye.
  static String? tokenValue;

  /// Sync: ApiClient har request mein isi se token leta hai
  static String? get token => tokenValue;

  /// Splash par check: login hai ya nahi
  static bool get hasToken => tokenValue != null && tokenValue!.isNotEmpty;

  /// main() mein runApp se pehle ek baar
  static Future<void> init() async {
    tokenValue = await storage.read(key: tokenKey);
  }

  /// Login / signup success par
  static Future<void> saveToken(String token) async {
    tokenValue = token;
    await storage.write(key: tokenKey, value: token);
  }

  /// Logout ya 401 par
  static Future<void> deleteToken() async {
    tokenValue = null;
    await storage.delete(key: tokenKey);
  }
}
