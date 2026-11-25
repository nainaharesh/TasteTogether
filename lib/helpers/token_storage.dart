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

  /// Login hai ya nahi (main.dart isi se pehli screen chunta hai)
  static bool get hasToken => tokenValue != null && tokenValue!.isNotEmpty;

  /// main() mein runApp se pehle ek baar.
  /// Kuch Android phones par keystore kharab ho jata hai (restore / update ke
  /// baad) aur read exception deta hai. Us par app crash na ho: storage saaf
  /// karo aur user ko dobara login par bhejo.
  static Future<void> init() async {
    try {
      tokenValue = await storage.read(key: tokenKey);
    } catch (_) {
      tokenValue = null;
      try {
        await storage.deleteAll();
      } catch (_) {}
    }
  }

  /// Login / signup success par. Disk write fail bhi ho to session isi run mein
  /// chalta rahe (token memory mein hai), login rukna nahi chahiye.
  static Future<void> saveToken(String token) async {
    tokenValue = token;
    try {
      await storage.write(key: tokenKey, value: token);
    } catch (_) {}
  }

  /// Logout ya 401 par. Memory pehle (sync), taake baaki requests ko turant
  /// token na mile.
  static Future<void> deleteToken() async {
    tokenValue = null;
    try {
      await storage.delete(key: tokenKey);
    } catch (_) {}
  }
}
