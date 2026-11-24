import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {

  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';

  // Memory cache for synchronous token access
  static String? _token;

  // Get the currently stored token from memory
  static String? get token => _token;

  // Check whether a token exists
  static bool get hasToken => _token != null && _token!.isNotEmpty;

  // Initialize token from secure storage
  static Future<void> init() async {
    _token = await _storage.read(key: _tokenKey);
  }

  // Save token after successful login
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    _token = token;
  }

  // Delete token during logout or unauthorized session
  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    _token = null;
  }
}
