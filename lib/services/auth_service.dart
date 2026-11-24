import 'package:tastetogether/models/auth/auth_models.dart';
import 'package:tastetogether/services/api/api_client.dart';
import 'package:tastetogether/services/api/api_endpoints.dart';

/// Auth ke saare API calls. Sirf endpoint + body + model: koi UI ya state nahi.
class AuthService {
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final json = await ApiClient.post(
      ApiEndpoints.login,
      body: {'email': email, 'password': password},
      auth: false, // abhi token hai hi nahi
    );
    return AuthResponse.fromJson(json as Map<String, dynamic>);
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
    return AuthResponse.fromJson(json as Map<String, dynamic>);
  }

  Future<void> logout() async {
    await ApiClient.post(ApiEndpoints.logout);
  }

  Future<void> forgotPassword({required String email}) async {
    await ApiClient.post(
      ApiEndpoints.forgotPassword,
      body: {'email': email},
      auth: false,
    );
  }

  /// UI screen abhi nahi (reset link email se khulta hai), service tayyar hai.
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

  /// Splash par: token abhi bhi sahi hai ya nahi
  Future<UserModel> getMyProfile() async {
    final json = await ApiClient.get(ApiEndpoints.myProfile) as Map<String, dynamic>;
    // TODO: Postman mein dekho: response { "user": {...} } hai ya seedha {...}
    return UserModel.fromJson((json['user'] ?? json) as Map<String, dynamic>);
  }
}
