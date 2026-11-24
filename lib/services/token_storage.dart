import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage._();

  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';

  /// Memory cache. Secure storage async hota hai, is liye token ek baar
  /// padh kar yahan rakh lete hain taake baaki jagah sync mil jaye.
  static String? _token;

  /// Sync: ApiClient har request mein isi se token leta hai
  static String? get token => _token;

  /// Splash par check: login hai ya nahi
  static bool get hasToken => _token != null && _token!.isNotEmpty;

  /// main() mein runApp se pehle ek baar
  static Future<void> init() async {
    _token = await _storage.read(key: _tokenKey);
  }

  /// Login / signup success par
  static Future<void> saveToken(String token) async {
    _token = token;
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Logout ya 401 par
  static Future<void> deleteToken() async {
    _token = null;
    await _storage.delete(key: _tokenKey);
  }
}
