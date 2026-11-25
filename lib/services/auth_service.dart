// ignore_for_file: deprecated_member_use
import 'package:tastetogether/models/auth/auth_models.dart';
import 'package:tastetogether/services/api/api_client.dart';
import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/api/api_endpoints.dart';

/// Auth ke saare API calls. Sirf endpoint + body + model: koi UI ya state nahi.
class AuthService {
  /// Response object na ho (khali / HTML) to saaf error, crash nahi.
  Map<String, dynamic> asMap(dynamic json) {
    if (json is Map) return json.cast<String, dynamic>();
    throw ApiException('Server ka jawab samajh nahi aaya. Dobara try karein.');
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final json = await ApiClient.post(
      ApiEndpoints.login,
      body: {'email': email, 'password': password},
      auth: false, // abhi token hai hi nahi
    );
    return AuthResponse.fromJson(asMap(json));
  }

  Future<AuthResponse> signup({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    final json = await ApiClient.post(
      ApiEndpoints.signup,
      body: {
        'fullName': fullName,
        'username': username,
        'email': email,
        'password': password,
      },
      auth: false,
    );
    return AuthResponse.fromJson(asMap(json));
  }

  Future<void> logout() async {
    await ApiClient.post(ApiEndpoints.logout);
  }

  /// Backend (abhi dev mode) response mein `resetToken` bhi bhejta hai.
  /// Mile to wapas karta hai (screen us se code field bhar deti hai),
  /// warna null (asli email se code aayega).
  Future<String?> forgotPassword({required String email}) async {
    final json = await ApiClient.post(
      ApiEndpoints.forgotPassword,
      body: {'email': email},
      auth: false,
    );
    final token = json is Map ? json['resetToken'] : null;
    return token == null || '$token'.isEmpty ? null : '$token';
  }

  /// Reset Password screen (reset_password_screen.dart) isay chalati hai.
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await ApiClient.post(
      ApiEndpoints.resetPassword,
      body: {'token': token, 'newPassword': newPassword},
      auth: false,
    );
  }

  /// GET /api/users/me -> user seedha (Postman se confirm, `{user: ...}` nahi)
  Future<UserModel> getMyProfile() async {
    final json = asMap(await ApiClient.get(ApiEndpoints.myProfile));
    return UserModel.fromJson(json);
  }

  /// PATCH /api/users/me -> sirf bheje hue fields badalte hain, poora user wapas.
  /// Misal: {'bio': '...'} ya {'pushPrefs': {...}}
  Future<UserModel> updateMyProfile(Map<String, dynamic> changes) async {
    final json = asMap(
      await ApiClient.patch(ApiEndpoints.myProfile, body: changes),
    );
    return UserModel.fromJson(json);
  }
}