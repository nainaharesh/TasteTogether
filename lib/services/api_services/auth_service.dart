import 'package:tastetogether/models/auth/auth_models.dart';
import 'package:tastetogether/services/api/api_client.dart';
import 'package:tastetogether/services/api/api_endpoints.dart';
import 'package:tastetogether/services/api/api_exception.dart';

class AuthService {
  // Convert API response into Map
  Map<String, dynamic> asMap(dynamic response) {
    if (response is Map<String, dynamic>) {
      return response;
    }

    throw ApiException('Invalid server response.');
  }

  // Login
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.post(
      ApiEndpoints.login,
      auth: false,
      body: {'email': email, 'password': password},
    );

    return AuthResponse.fromJson(asMap(response));
  }

  // Signup
  Future<AuthResponse> signup({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.post(
      ApiEndpoints.signup,
      auth: false,
      body: {
        'fullName': fullName,
        'username': username,
        'email': email,
        'password': password,
      },
    );

    return AuthResponse.fromJson(asMap(response));
  }

  // Logout
  Future<void> logout() async {
    await ApiClient.post(ApiEndpoints.logout);
  }

  // Forgot Password
  Future<String?> forgotPassword({required String email}) async {
    final response = await ApiClient.post(
      ApiEndpoints.forgotPassword,
      auth: false,
      body: {'email': email},
    );

    final data = asMap(response);

    return data['resetToken'] as String?;
  }

  // Reset Password
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await ApiClient.post(
      ApiEndpoints.resetPassword,
      auth: false,
      body: {'token': token, 'newPassword': newPassword},
    );
  }
}
